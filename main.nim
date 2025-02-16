import os
import stb_image/read as stbi

let
    a = "@#&*+=-_:.'\"<>,?/|\\^~`;{}[]()!%$"

type
    Image = object
        pixel: seq[uint8]
        width, height, channels: int
var
    image: Image

proc main() =
    let args = commandLineParams()
    if args.len == 0:
        echo "Usage: program <image_path>"
        return

    image.pixel = stbi.load(args[0], image.width, image.height, image.channels, stbi.Default)
    for y in 0..<image.height:
        for x in 0..<image.width:
            let offset: int = (y * image.width + x) * image.channels

            var r: uint8 = image.pixel[offset]
            var g: uint8 = image.pixel[offset + 1]
            var b: uint8 = image.pixel[offset + 2]

            let gray: uint8 = (0.2989 * float(r) + 0.5870 * float(g) + 0.1140 * float(b)).uint8

            image.pixel[offset] = gray
            image.pixel[offset + 1] = gray
            image.pixel[offset + 2] = gray

            r = image.pixel[offset]
            g = image.pixel[offset + 1]
            b = image.pixel[offset + 2]

            let y = 0.2126 * float(r) + 0.7152 * float(g) + 0.0722 * float(b)
            let index: char = a[int(y / 25)]

            stdout.write(index)

        echo " "
    
when isMainModule:
    main()

