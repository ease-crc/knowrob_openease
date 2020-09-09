% make sure library path is expanded
:- register_ros_package(knowrob_openease).
:- register_ros_package(knowrob).

% load modules
:- use_module('./query_handler.pl').