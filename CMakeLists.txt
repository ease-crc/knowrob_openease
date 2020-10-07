cmake_minimum_required(VERSION 3.0.2)
project(knowrob_openease)

##############################################################################
# Catkin
##############################################################################

find_package(catkin REQUIRED message_generation knowrob)

add_message_files(FILES Highlight.msg)
generate_messages(DEPENDENCIES std_msgs)

catkin_package(
  DEPENDS knowrob
)

##############
##############

install(DIRECTORY owl/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/owl)

install(DIRECTORY prolog/
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/prolog)
