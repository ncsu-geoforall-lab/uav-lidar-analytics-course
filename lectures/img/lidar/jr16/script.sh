g.region rast3d=elev_7412_2m@Jockeys_Ridge

# isosurface level
LEVEL=16
# sequence of cutting planes hight 0 to 60 by 5
for HEIGHT in `seq -f %02g 0 5 60`
do

echo $HEIGHT
m.nviz.image elevation_map=elev_2009_1m@Jockeys_Ridge -a mode=fine resolution_fine=2 color_map=ridge_shaded@Jockeys_Ridge \
volume=elev_7412_2m@Jockeys_Ridge volume_shading=gouraud volume_resolution=1 volume_position=0,0,20 isosurf_level=1:$LEVEL \
isosurf_color_map=color_volume@Jockeys_Ridge isosurf_transp_value=0 position=0.34,0.87 height=558 perspective=22 twist=0 zexag=4.000000 focus=541,529,13 \
cplane=0 cplane_rotation=180 cplane_tilt=90 cplane_position=0,0,${HEIGHT} cplane_shading=shaded \
light_position=-0.59,-0.76,0.80 light_brightness=80 light_ambient=20 light_color=255:255:255 \
arrow_position=686,77 arrow_color=0:0:0 arrow_size=100 output=plane_$HEIGHT format=ppm size=751,649 -n --q

done

# create animated GIF
convert -delay 1x3  `seq -f plane_%02g.ppm 0 5 60` -coalesce -layers OptimizeTransparency animation.gif
# add prepared legend file
convert animation.gif -coalesce -gravity SouthWest -draw 'image over 20,35 0,0 "legend.png"' -layers Optimize animation_legend.gif
# add delay after last slide
convert animation_legend.gif \( +clone -set delay 200 \) +swap +delete  animation.gif
# remove temporary file
rm animation_legend.gif
