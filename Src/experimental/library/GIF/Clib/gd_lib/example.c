/* Bring in gd library functions */
#include "gd.h"

/* Bring in standard I/O so we can output the GIF to a file */
#include <stdio.h>

int main() {
        /* Declare the image */
        gdImagePtr im;
        /* Declare an output file */
        FILE *out;
        /* Declare color indexes */
        int black;
        int white;

        /* Allocate the image: 64 pixels across by 64 pixels tall */
        im = gdImageCreate(64, 64);

        /* Allocate the color black (red, green and blue all minimum).
                Since this is the first color in a new image, it will
                be the background color. */
        black = gdImageColorAllocate(im, 0, 0, 0);

        /* Allocate the color white (red, green and blue all maximum). */
        white = gdImageColorAllocate(im, 255, 255, 255);
        
        /* Draw a line from the upper left to the lower right,
                using white color index. */
        gdImageLine(im, 0, 0, 63, 63, white);

        /* Open a file for writing. "wb" means "write binary", important
                under MSDOS, harmless under Unix. */
        out = fopen("test.gif", "wb");

        /* Output the image to the disk file. */
        gdImageGif(im, out);

        /* Close the file. */
        fclose(out);

        /* Destroy the image in memory. */
        gdImageDestroy(im);
}