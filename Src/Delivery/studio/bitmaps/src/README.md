On linux shell:

One time: 
```
	./extract_all_png.sh
```

Then to generate the png files:
```
	./build_all_icons_matrix.sh
```

And during development, you can see the difference between previous PNG and new SVG:
```
	./build_all_diff.sh
```


Requirements:
- convert, identify from https://imagemagick.org/
- optionally inkscape.
