:- module(canvas_handler,[]).

:- use_module(library(query_handler)).

query_handler:openease_gen_answer(is_event(Evt)) :-
	ask(aggregate([
		triple(Evt,dul:hasTimeInterval,Interval),
		triple(Interval,soma:hasIntervalBegin,Time)
	])),
    marker_plugin:show_markers(Time).
