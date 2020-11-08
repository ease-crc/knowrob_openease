:- module(canvas_handler,[]).

:- use_module(library(query_handler)).

query_handler:openease_gen_answer(event,Evts) :-
	% TODO: handle multiple events
	once(member(Evt,Evts)),
%	ask(aggregate([
%		triple(Evt,dul:hasTimeInterval,Interval),
%		triple(Interval,soma:hasIntervalBegin,Time)
%	])),
	get_time(Time),
    marker_plugin:show_markers(Time).
