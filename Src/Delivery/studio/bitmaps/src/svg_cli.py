#!/usr/bin/python

# Usage:
#	svg_cli.py add base.svg one.svg two.svg ... output.svg
# 		Add one.svg, two.svg, and so on to the base.svg images and save into output.svg
# 		i.e base.svg + one.svg + two.svg -> output.svg
# 		note that due to svg stacking behavior, the last image added will appear over the previous.
#	svg_cli.py filter (grey|light|frozen) base.svg output.svg
#	svg_cli.py rotate deg base.svg output.svg
#	svg_cli.py overlay (region=nw|ne|se|sw) {scale=.50} base.svg output.svg
#		region: nw=NorthWest (i.e top right), ...
#		scale: by default .50
#
# Note: 
# before using this script, it is recommended to use https://github.com/RazrFalcon/svgcleaner on the svg images. So that the svg content is cleaned for non svg data, and it gets easier to manipulate the SVG/XML structure.

from xml.etree import ElementTree
import sys

dbg=False
#dbg=True

def next_id(a_id, a_list):
	if len(a_id) > 1 or a_id == 'z':
		i = 1
		l_id = a_id
		while l_id in a_list:
			l_id = "%s%d"% (a_id, i)
			i = i + 1
	else:
		l_id = a_id
		while l_id in a_list:
			l_id = chr(ord(l_id) + 1)
	return l_id

def svgadd(x_left, ids, right):
	x_right = ElementTree.parse(right).getroot()
	new_ids={} # new id, indexed by old id.
	svg_update_ids(x_right, ids, new_ids)
	if dbg: svg_showids("ids", ids)
	if dbg: svg_showids("new_ids", new_ids)
	for e in x_right:
		x_left.append(e)

def svg_update_ids(x, ids, local_ids):
	#local_ids={} # new id, indexed by old id.
	for e in x.iter('*'):
		l_id = e.get('id')
		if l_id:
			if l_id in ids:
				l_new_id = next_id(l_id, ids)
				local_ids[l_id] = l_new_id 
				e.set('id', l_new_id)
				ids.append(l_new_id)
				if dbg: print ("Id: %s -> %s"% (l_id, l_new_id))
			else:
				if dbg: print ("Id: %s -> %s"% (l_id, l_id))
				local_ids[l_id] = l_id 
				ids.append(l_id)
	for e in x.iter('*'):
		for k in e.attrib:
			v = e.attrib[k]
			if dbg: print ("(%s => %s)"%(k, v))
			if svg_attribname (k) == "href":
				l_ref_id = v[1:]
				l_new_ref_id = local_ids[l_ref_id]
				if dbg: print ("Found HREF %s -> %s"% (l_ref_id, l_new_ref_id))
				if l_new_ref_id:
					e.set(k,"#%s"%(l_new_ref_id))
			elif v[0:5] == 'url(#':
				l_ref_id = v[5:-1]
				if l_ref_id:
					l_new_ref_id = local_ids[l_ref_id]
					if dbg: print ("Found URL %s -> %s"% (l_ref_id, l_new_ref_id))
					if l_new_ref_id:
						e.set(k,"url(#%s)"%(l_new_ref_id))

def svg_getids(x, ids):
	# Records the various id="..." 
	for e in x:
		if e.get('id'):
			ids.append (e.get('id'))
		else:
			svg_getids(e, ids)

def svg_tagname(e):
	e_tag = e.tag
	i = e_tag.find("}")
	if i > 0:
		e_tag = e_tag[i+1:]
	return e_tag

def svg_attribname(k):
	l_name = k
	i = l_name.find("}")
	if i > 0:
		l_name = l_name[i+1:]
	return l_name

def svg_showids(n, ids):
		sys.stdout.write ("%s: " % (n))
		for i in ids:
			sys.stdout.write ("%s " % (i))
		sys.stdout.write("\n")

ElementTree.register_namespace('', 'http://www.w3.org/2000/svg')
ElementTree.register_namespace('xlink', "http://www.w3.org/1999/xlink")

nb = len(sys.argv)
if nb > 1:
	command=sys.argv[1]

	if nb > 3 and command == "add":
		base=sys.argv[2]
		output=sys.argv[nb - 1]
		if dbg: print ("ADD -> %s"% (output))
		r=3

		x_base = ElementTree.parse(base).getroot()
		base_ids = []
		svg_getids(x_base, base_ids)
		if dbg: svg_showids("base_ids", base_ids)
		for r in range(2, nb - 1):
			right=sys.argv[r]
			svgadd(x_base, base_ids, right)
			if dbg: svg_showids("base_ids", base_ids)

		#ElementTree.dump(x_base)
		ElementTree.ElementTree(x_base).write(output)
		print ("Add: output saved into %s"% (output))
	elif nb > 4 and command == "overlay":
		reg=sys.argv[2]
		if nb > 5:
			l_scale = float(sys.argv[3])
			base=sys.argv[4]
		else:
			l_scale = .50
			base=sys.argv[3]
		output=sys.argv[nb - 1]
		# check nb == 4
		if dbg: print ("Overlay(%s)+Scale(%s) -> %s"% (reg, l_scale, output))
		l_page_size=100
		if reg == 'nw':
			x=0
			y=0
		elif reg == 'ne':
			x=l_page_size * (1 - l_scale) / l_scale
			y=0
		elif reg == 'sw':
			x=0
			y=l_page_size * (1 - l_scale) / l_scale
		elif reg == 'se':
			x=l_page_size * (1 - l_scale) / l_scale
			y=l_page_size * (1 - l_scale) / l_scale
		elif reg == 's':
			x=l_page_size / 4 / l_scale
			y=l_page_size * (1 - l_scale) / l_scale
		elif reg == 'n':
			x=l_page_size / 4 / l_scale
			y=0
		elif reg == 'e':
			x=l_page_size * (1 - l_scale) / l_scale
			y=l_page_size / 4 / l_scale
		elif reg == 'w':
			x=0
			y=l_page_size / 4 / l_scale
		elif reg == 'c':
			x=l_page_size / 4 / l_scale
			y=l_page_size / 4 / l_scale
		else:
			# same as 'c' for center
			x=l_page_size / 4 / l_scale
			y=l_page_size / 4 / l_scale

		l_group_id = "src"

		x_base = ElementTree.parse(base).getroot()
		x_base.set("xmlns:xlink", "http://www.w3.org/1999/xlink")
		base_ids = []
		svg_getids(x_base, base_ids)
		l_group_id = next_id(l_group_id, base_ids)


		x_defs = ElementTree.fromstring("<defs/>")
		x_gsrc = ElementTree.fromstring("<g id=\"%s\"/>" % (l_group_id))
		elts=[]
		for e in x_base:
			elts.append (e)
		for e in elts:
			x_base.remove (e)
			x_gsrc.append (e)

		x_defs.append (x_gsrc)
		x_base.append (x_defs)
		l_use = "<use xlink-href=\"#%s\" x=\"%s\" y=\"%s\" transform=\"scale(%s)\"/>" % (l_group_id, x, y, l_scale)
		x_use = ElementTree.fromstring(l_use)
		x_base.append (x_use)
		svg = ElementTree.tostring(x_base, encoding="unicode")
		svg = svg.replace("xlink-href", "xlink:href")

#		svg="""<svg height="100" viewBox="0 0 100 100" width="100" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><image x="%s" y="%s" width="%s" height="%s" xlink:href="%s"/></svg>""" % (x, y, l_size, l_size, base)
		f=open(output, 'w')
		f.write (svg)
		f.close ()

		print ("%s(%s)+scale(%s): output saved into %s"% (command, reg, l_scale, output))
	elif nb > 4 and command == "rotate":
		deg=sys.argv[2]
		base=sys.argv[3]
		output=sys.argv[nb - 1]
		if dbg: print ("Rotate(%s) -> %s"% (deg, output))
		l_group_id = "src"
		x_base = ElementTree.parse(base).getroot()
		x_base.set("xmlns:xlink", "http://www.w3.org/1999/xlink")
		base_ids = []
		svg_getids(x_base, base_ids)
		l_group_id = next_id(l_group_id, base_ids)

		x_defs = ElementTree.fromstring("<defs/>")
		x_gsrc = ElementTree.fromstring("<g id=\"%s\"/>" % (l_group_id))
		elts=[]
		for e in x_base:
			elts.append (e)
		for e in elts:
			x_base.remove (e)
			x_gsrc.append (e)

		x_defs.append (x_gsrc)
		x_base.append (x_defs)
		l_page_size=100
		l_use = "<use xlink-href=\"#%s\" transform=\"rotate(%s %s,%s)\"/>" % (l_group_id, deg, l_page_size / 2, l_page_size /2)
		x_use = ElementTree.fromstring(l_use)
		x_base.append (x_use)
		svg = ElementTree.tostring(x_base, encoding="unicode")
		svg = svg.replace("xlink-href", "xlink:href")
		f=open(output, 'w')
		f.write (svg)
		f.close ()
		print ("%s(%s): output saved into %s"% (command, deg, output))
	elif nb > 3 and command == "filter":
		l_filter_name=sys.argv[2]
		base=sys.argv[3]
		output=sys.argv[nb - 1]
		if dbg: print ("ADD -> %s"% (output))

		x_base = ElementTree.parse(base).getroot()
		base_ids = []
		svg_getids(x_base, base_ids)
		if dbg: svg_showids("base_ids", base_ids)
		l_filter_id = l_filter_name
		if l_filter_id in base_ids:
			l_filter_id = next_id(l_filter_id,base_ids)

		if dbg: svg_showids("base_ids", base_ids)
		if l_filter_name == "grey":
			l_filter = """<filter id="%s" color-interpolation-filters="sRGB"><feColorMatrix values="0.4 0.4 0.4 0 0 0.4 0.4 0.4 0 0 0.4 0.4 0.4 0 0 0 0 0 1 0"/></filter>""" % (l_filter_id)
		elif l_filter_name == "light":
			l_filter = """<filter id="%s" color-interpolation-filters="sRGB"><feColorMatrix values="1 0 0 0.25 -0 0 1 0 0.25 -0 0 0 1 0.25 -0 0 0 0 1 0"/></filter>""" % (l_filter_id)
		elif l_filter_name == "frozen":
			l_filter = """<filter id="%s" color-interpolation-filters="sRGB">
		<feComposite in2="SourceGraphic" k1="0" k2="1" operator="arithmetic" result="composite1"/>
		<feColorMatrix in="composite1" result="colormatrix1" type="saturate" values="0"/>
		<feFlood flood-color="#00c0db" result="flood1"/>
		<feBlend in="flood1" in2="colormatrix1" mode="screen" result="blend1"/>
		<feBlend in2="blend1" mode="multiply" result="blend2"/>
		<feColorMatrix in="blend2" result="colormatrix2" type="saturate" values="1"/>
		<feComposite in="colormatrix2" in2="SourceGraphic" k2="1" operator="in" result="composite2"/></filter>""" % (l_filter_id)

		x_filter = ElementTree.fromstring(l_filter)

		x_base.insert(0, x_filter)
		base_ids.append(l_filter_id)

#		elts=[]

		for e in x_base:
			l_tag = svg_tagname (e)
			if l_tag == 'g' or l_tag == 'path':
				if not "filter" in e.attrib or e.attrib["filter"] == "none":
					e.set("filter", "url(#%s)" % (l_filter_id));
				else:
					ef = ElementTree.fromstring("<g filter=\"url(#%s)\"></g>" % (l_filter_id))
					#ElementTree.dump(ef)
#					elts.append(e)
					x_base.remove(e)
					ef.append(e)
					x_base.append(ef)

#		for e in elts:
#			x_base.remove (e)

		#ElementTree.dump(x_base)
		ElementTree.ElementTree(x_base).write(output)
		print ("%s %s: output saved into %s"% (command, l_filter_name, output))
	else:
		print ("Invalid command!")

else:
	sys.exit()

