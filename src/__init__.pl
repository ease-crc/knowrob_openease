% make sure library path is expanded
:- register_ros_package(knowrob_openease).
:- register_ros_package(knowrob).

% load query tunnling
:- use_module('./query_handler.pl').
:- use_module('./query_history.pl').

% load marker visualization
:- use_directory('marker_vis').
% load IDE interface
:- use_directory('ide').

% load backends for query visualization
:- use_module('./backends/canvas.pl').
:- use_module('./backends/timeline.pl').

