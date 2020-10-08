#! /usr/bin/python
# Copyright (c) 2015, Rethink Robotics, Inc.

# Using this CvBridge Tutorial for converting
# ROS images to OpenCV2 images
# http://wiki.ros.org/cv_bridge/Tutorials/ConvertingBetweenROSImagesAndOpenCVImagesPython

# Using this OpenCV2 tutorial for saving Images:
# http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_gui/py_image_display/py_image_display.html

import os
# rospy for the subscriber
import rospy
# ROS Image message
from sensor_msgs.msg import Image
# ROS Image message -> OpenCV2 image converter
from cv_bridge import CvBridge, CvBridgeError
# OpenCV2 for saving an image
import cv2

# Instantiate CvBridge
bridge = CvBridge()

def image_callback(msg):
	print("Received an image!")
	# make sure dir in user volume exists
	imgdir = '/home/ros/user_data/snapshots/'
	if not os.path.exists(imgdir):
		os.makedirs(imgdir)
	# write file into user_data volume
	filepath = imgdir+str(msg.header.frame_id)+'.jpeg'
	try:
		# Convert your ROS Image message to OpenCV2
		cv2_img = bridge.imgmsg_to_cv2(msg, "bgr8")
		# Save your OpenCV2 image as a jpeg 
		cv2.imwrite(filepath, cv2_img)
	except e:
		print(e)

if __name__ == '__main__':
	rospy.init_node('image_listener')
	# Define your image topic
	image_topic = "/openease/video/frame"
	# Set up your subscriber and define its callback
	rospy.Subscriber(image_topic, Image, image_callback)
	# Spin until ctrl + c
	rospy.spin()

