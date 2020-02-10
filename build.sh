#!/bin/bash

# builds pages from source

function build_page_general {
    FILE_SOURCE=$1
    FILE_TARGET=$2
    HEAD_FILE=$3
    FOOT_FILE=$4
    OUTDIR=$5
    cat $HEAD_FILE > $OUTDIR/$FILE_TARGET
    echo "<!-- This is a generated file. Do not edit. -->" >> $OUTDIR/$FILE_TARGET
    cat $FILE_SOURCE >> $OUTDIR/$FILE_TARGET
    cat $FOOT_FILE >> $OUTDIR/$FILE_TARGET
}

function build_page {
    build_page_general $1 $2 $HEAD_FILE $FOOT_FILE $OUTDIR
}

HEAD_FILE=head.html
FOOT_FILE=foot.html

OUTDIR="build"

if [ ! -d "$OUTDIR" ]; then
    mkdir $OUTDIR
    echo "Creating directory $OUTDIR automatically."
    echo "If you are using GitHub pages to create publish the website,"
    echo "you probably want to create this directory by a dedicated script."
fi

# disable Jekyll which is not needed for out GitHub pages
touch $OUTDIR/.nojekyll

if [ ! -d "$OUTDIR" ]; then
    echo "The directory $OUTDIR does not exists and it will be created for you."
    mkdir $OUTDIR
fi

for FILE in `ls *.html|grep -v foot|grep -v head`
do
    build_page $FILE $FILE
done

# Topics index
FILES="`./extract-links.py "topics/.+html" schedule.html`"
TITLE="Topics"
HEAD_TEXT=""
# if this gets longer, it must go to a file
FOOT_TEXT="<h3>Related courses</h3>

To learn more about these topics, here are some
<a href=\"https://geospatial.ncsu.edu/geoforall/courses.html\">related courses</a>
which may be useful for you."
DIR="topics"

TGT_FILE=$OUTDIR/topics.html
cat < $HEAD_FILE > $TGT_FILE
echo "<!-- This is a generated file. Do not edit. -->" >> $TGT_FILE
./generate-index.py "$TITLE" "$HEAD_TEXT" "$FOOT_TEXT" "" ul ul $FILES >> $TGT_FILE
cat < $FOOT_FILE >> $TGT_FILE

for DIR in assignments topics
do
    mkdir -p $OUTDIR/$DIR

    for FILE in `ls $DIR/*.html`
    do
        TGT_FILE=$OUTDIR/$DIR/`basename $FILE`
        ./increase-link-depth.py < $HEAD_FILE > $TGT_FILE
        echo "<!-- This is a generated file. Do not edit. -->" >> $TGT_FILE
        ./color-comments.py < $FILE | ./strip-whitestace.py >> $TGT_FILE
        ./increase-link-depth.py < $FOOT_FILE >> $TGT_FILE
    done

    for SUBDIR in data img resources
    do
        # copy only if directory exists
        if [ -d "$DIR/$SUBDIR" ]; then
            cp -r $DIR/$SUBDIR $OUTDIR/$DIR
        fi
    done
done

if [ ! -d "$OUTDIR/lectures" ]; then
    mkdir $OUTDIR/lectures
fi

for FILE in lectures/*
do
    if [ ${FILE: -5} == ".html" ]; then
        if [ ${FILE: -9} == "head.html" ] || [ ${FILE: -9} == "foot.html" ]; then
            continue
        fi
        build_page_general $FILE $FILE lectures/head.html lectures/foot.html $OUTDIR
    else
        cp -r $FILE $OUTDIR/lectures
    fi
done

for FILE in *.css
do
    cp $FILE $OUTDIR
done

for DIR in img
do
    cp -r $DIR $OUTDIR
done

# backwards compatibility
cp $OUTDIR/assignments/lidar_import.html $OUTDIR/instructions_lidar_upload.html
cp $OUTDIR/assignments/trimble_install.html $OUTDIR/instructions_trimble.html
