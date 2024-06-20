.PHONY: focal-rt-ros2 jammy-rt-ros2 clean

jammy-rt-rolling:
	sudo ./ros-rt-img build jammy-rt jammy-rt-rolling

# TODO: eventually the build.py should be a command line script that takes
#       arguments
jammy-rt-ros2:
	sudo ./ros-rt-img build jammy-rt jammy-rt-humble


riscv-rt:
	sudo ./ros-rt-img build riscv-rt

clean:
	sudo ./ros-rt-img teardown
	sudo rm -rf out cache
