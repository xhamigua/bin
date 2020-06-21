@ECHO OFF
:INIT
SET DARKNET=data\YoloCPU64.exe
IF /i "%1" == "GPU" (SET DARKNET=data\YoloGPU64.exe)
IF /i "%1" == "CPU" (SET DARKNET=data\YoloCPU64.exe)
REM =======================Çø·ÖGPU/CPU==================================
::SET GPU=0
::SET NAMES=mo/head/labels.names
::SET CFG=mo/head/yolov3-tiny-head.cfg
::SET WEIGHT=mo/head/yolov3-tiny-head.mo
::SET COCO=mo/head/coco.data
::SET DARKNET=data\YoloCPU64.exe
::IF /i %GPU%==1 (SET DARKNET=data\YoloGPU64.exe) 
REM =======================yolo_sample_predict==========================
::%DARKNET% detector test data/yolov3/yolov3.data data/yolov3/yolov3.cfg data/yolov3/yolov3.mo data/dog.jpg
::%DARKNET% detector test data/tiny/yolov3-tiny.data data/tiny/yolov3-tiny.cfg data/tiny/yolov3-tiny.mo data/dog.jpg
::%DARKNET% detector demo mo/digger/coco.data mo/digger/digger.cfg mo/digger/digger.mo sample/digger/video/ok1.mp4
REM =======================yolo_fast_predict============================
::%DARKNET% yolo_fast --coco=%NAMES% --cfg=%CFG% --weight=%WEIGHT% --image=digger/test.jpg
::%DARKNET% yolo_fast --coco=%NAMES% --cfg=%CFG% --weight=%WEIGHT% --video=digger/test.mp4
::%DARKNET% yolo_fast --coco=%NAMES% --cfg=%CFG% --weight=%WEIGHT% --device=0
REM =======================yolo_train===================================
::%DARKNET% detector train Train/lotus/sing.data -map Train/lotus/train_tiny.cfg -dont_show
::%DARKNET% detector train Train/lotus/sing.data -map Train/lotus/train_tiny.cfg -dont_show -gpus 0,1
REM =======================yolo_MARK====================================
::%DARKNET% yolo_mark Train/lotus/img Train/lotus/img/train.txt Train/lotus/img/labels.names
REM =======================yolo_CutPic==================================
::%DARKNET% cutpic test.mp4 pic 5
::@dir /b /s pic\*.jpg>train.txt
::@TIMEOUT 10
::for /f "delims=" %%k in ('DIR /s/a-d /b *.mp4') do (%DARKNET% cutpic %%k  %%~nk  20)
REM ====================================================================
GOTO EOF


:END
EXIT
:EOF
