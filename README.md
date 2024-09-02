# NPU Top

As of now, specifically for the Rockchip RK3588 CPU that contains 3 NPUs @ 2 TOPS each for a total of 6 TOPS.

## Orange Pi 5

### Folders

Information stems from these folders on the Orange Pi 5 (OPi5):

* /proc/rknpu
* /sys/class/devfreq/fdab0000.npu/
* /sys/class/devfreq/fdab0000.npu/power

## TODO

Identify NPUs through `dmesg` filtering.

Tera-Operations Per Second (TOPS) default is INT8.

* Google Coral USB Accelerator (4 TOPS)
* Hailo-8L (13 TOPS)
* Intel Neural Compute Stick 2 (4 TOPS)
* Orange Pi AI Stick Lite (5.6 TOPS)
* Rockchip CPUs
  * RK1808 (3 TOPS)
  * RK3399 (3 TOPS)
  * RK3568 (0.8 TOPS)
  * RK3588 (6 TOPS)
* Toybrick TB-RK1808 AI Compute Stick (3 TOPS)

## Resources

* [Bash Simple Curses](https://github.com/metal3d/bashsimplecurses)
