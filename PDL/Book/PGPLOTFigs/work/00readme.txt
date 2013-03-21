# conversion for PDF document
# has to be 8 bit PNG and reasonably bigger size
for i in *.pdf; do convert -rotate 90 -resize 800x $i -depth 8 ${i%%.pdf}.8.png; done
#
#
#
# commands used to convert images from LyX book format to png for pod2html

convert -rotate 90 -resize 300x PGPLOTFigs/ex_env2.pdf PGPLOTFigs/ex_env2.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_points.pdf PGPLOTFigs/ex_points.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_points2.pdf PGPLOTFigs/ex_points2.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_errb.pdf PGPLOTFigs/ex_errb.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_errb2.pdf PGPLOTFigs/ex_errb2.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_line1.pdf PGPLOTFigs/ex_line1.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_bin.pdf PGPLOTFigs/ex_bin.png
convert -rotate 90 -resize 300x PGPLOTFigs/linepoly_ex.pdf PGPLOTFigs/linepoly_ex.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_imag1.pdf PGPLOTFigs/ex_imag1.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_imag2.pdf PGPLOTFigs/ex_imag2.png
convert -rotate 90 -resize 500x PGPLOTFigs/eg_wedge.ps PGPLOTFigs/eg_wedge.png
convert -rotate 90 -resize 500x PGPLOTFigs/eg_cont1.ps PGPLOTFigs/ex_cont1.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_cont1.pdf PGPLOTFigs/ex_cont1.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_cont2.pdf PGPLOTFigs/ex_cont2.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_vec1.pdf PGPLOTFigs/ex_vec1.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_circle1.pdf PGPLOTFigs/ex_circle1.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_ellipse1.pdf PGPLOTFigs/ex_ellipse1.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_rect1.pdf PGPLOTFigs/ex_rect1.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_text1.pdf PGPLOTFigs/ex_text1.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_legend1.pdf PGPLOTFigs/ex_legend1.png
convert -rotate 90 -resize 500x PGPLOTFigs/ex_col1.pdf PGPLOTFigs/ex_col1.png
convert -resize 600x PGPLOTFigs/ColorTables.png PGPLOTFigs/ColorTables2.png
convert -rotate 90 -resize 300x PGPLOTFigs/ex_tline1.pdf PGPLOTFigs/ex_tline1.png

