#!/bin/bash
# NAME:         dropshadow.sh
# VERSION:
# AUTHOR:       (c) 2017 Taylor Thurlow
# DESCRIPTION:  - adds transparent dropshadow to images (e.g. screenshots)
#               - moves them to predefined screenshot folder
#               - notifies the user
# FEATURES:
# DEPENDENCIES: imagemagick suite
#
# LICENSE:      MIT license (http://opensource.org/licenses/MIT)
#
# NOTICE:       THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
#               INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
#               PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#               LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#               TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
#               OR OTHER DEALINGS IN THE SOFTWARE.
#
#
# USAGE:        dropshadow.sh <image>

SCREENSHOTFOLDER="$HOME/Screenshots"

FILE="${1}"
FILENAME="${FILE##*/}"
FILEBASE="${FILENAME%.*}"

# drop shadow: 60% opacity, 10 sigma, +0x +10y
convert "${FILE}" \( +clone -background black -shadow 60x10+0+10 \) +swap -background transparent -layers merge +repage "$SCREENSHOTFOLDER/${FILEBASE}.png"

notify-send -u low -t 2 "${FILEBASE}.png saved."

rm "$FILE" #remove this line to preserve original image
