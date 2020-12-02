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
- if possible, install inkscape ( >= 1.0) as the result is more stable.
note: imagemagick should be compiled with --with-rsvg ...otherwise the result is bad.
TODO: find better solution for convert.
