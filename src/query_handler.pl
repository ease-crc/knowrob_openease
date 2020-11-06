:- module(query_handler,
    [ 
    	openease_query(t,r)
    ]).

%:- use_module(library(data_vis)).

:- multifile openease_gen_answer/1.

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
	% call the query and ground vars
	call(Query),
	% generate answers
	thread_create(openease_gen_answers(Query),_).

%%
openease_gen_answers(Query) :-
	forall(
		openease_gen_answer(Query),
		true
	).

