import os

flags = os.listdir("flags_svg")

svgs = []
for f in flags:
    extension = os.path.splitext(f)[1]
    if extension == ".svg":
        svgs.append(f)

# using inkscape in commandline mode to convert svg to png
# choosing the ouput png to be have 170px height
for svg in svgs:
    svg_path = os.path.join("flags_svg", svg)
    png_path = os.path.join("flags", svg.split(".svg")[0] + ".png")
    os.system("inkscape {} --export-png={} --without-gui -h 170".format(svg_path, png_path))
