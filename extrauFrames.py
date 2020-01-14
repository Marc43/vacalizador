import cv2
import sys, os

if len(sys.argv) != 3:
    print "Usage: python extrauFrames.py path-al-video num-frames-a-extraure"
    sys.exit(1)

path = sys.argv[1]
nframes = int(sys.argv[2])

vidcap = cv2.VideoCapture(path)
success,image = vidcap.read()
count = 0

videoname = os.path.basename(path)
videoname = os.path.splitext(videoname)[0]

internal_counter = 0

while success:

    success,image = vidcap.read()

    if count == nframes:
        break
    elif internal_counter == 25:
        count += 1
        cv2.imwrite("%s_%d.jpg" % (videoname,count), image)     # save frame as JPEG file      
        internal_counter = 0

    internal_counter = internal_counter + 1

