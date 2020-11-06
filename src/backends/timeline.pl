:- module(timeline_handler,[]).

:- use_module(library(query_handler)).

query_handler:openease_gen_answer(is_event(_Evt)) :-
    findall([E,Task,Start,End],
    	timeline_data(E,Task,Start,End),
    	EventData),
    data_vis:timeline_data(EventData).

%%
timeline_data(E,Task,Start,End) :-
	ask(aggregate([
				triple(E,rdf:type,dul:'Event'),
				triple(E,rdf:type,regex('^.*(?!Action).*')),
				triple(E,dul:isClassifiedBy,TaskInstance),
				triple(E,dul:hasTimeInterval,Interval),
				triple(Interval,soma:hasIntervalBegin,Start),
				triple(Interval,soma:hasIntervalEnd,End)
			])),
	atomic_list_concat([Task,_],'_',TaskInstance).
