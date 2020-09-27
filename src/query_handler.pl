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
    gen_msgs(Query).

gen_msgs(is_event(_)) :-
 	setof(E,
 		(
 			is_event(E),
 			not(is_action(E))
 		),Events),
 	data_vis:timeline(Events),
 	%%
    member(NextEvent,Events),
    create_marker(NextEvent).

create_marker(Event) :-
	interval(Event,[T1,_]),
	show_markers(T1).