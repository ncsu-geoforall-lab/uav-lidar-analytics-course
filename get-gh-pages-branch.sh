remote=$(git config --get remote.origin.url)

build_dir="build"

if [ -d $build_dir/.git ]; then
    echo "The .git directory already exists in the build directory."
    echo "This probably means that you have already cloned a reposiory there."
    echo "You can proabbaly start publishing but if you are not sure use"
    echo "    rm -rf $build_dir"
    echo "to remove the whole build directory and start over."
    exit 1
fi

rm -r $build_dir

git clone $remote $build_dir

cd $build_dir

git checkout gh-pages
