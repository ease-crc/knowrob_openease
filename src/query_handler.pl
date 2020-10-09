:- module(query_handler,
    [ 
    	openease_query(t,r),
    	gen_msgs(t)
    ]).

%:- use_module(library(data_vis)).

/** <module> Tunnels queries of openEASE and executes other actions if necessary.

@author Daniel Beßler
@license BSD
*/

%% openease_query(+Query, +Mode) is nondet.
%
% True for statements that hold during the whole
% duration of some time interval.
%
% @param Query The query to be executed
% @param Mode A list of modes for the execution.
%
openease_query(Query, Mode) :-
    call(Query),
    ignore(gen_msgs(Query)).

get_event_data(E,Task,Start,End) :-
	ask(aggregate([
				triple(E,rdf:type,dul:'Event'),
				triple(E,rdf:type,regex('^.*(?!Action).*')),
				triple(E,dul:isClassifiedBy,TaskInstance),
				triple(E,dul:hasTimeInterval,Interval),
				triple(Interval,soma:hasIntervalBegin,Start),
				triple(Interval,soma:hasIntervalEnd,End)
			])),
	atomic_list_concat([Task,_],'_',TaskInstance).

gen_msgs(is_event(X)) :-
    findall([E,Task,Start,End],(get_event_data(E,Task,Start,End)),EventData),
    data_vis:timeline_data(EventData),
    %%
    once(member([X,_,Time,_],EventData)),
    marker_plugin:show_markers(Time).

