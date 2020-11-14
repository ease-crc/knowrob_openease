:- module(neems,
	[ neem_init/1
	]).

neem_init(NEEM_id) :-
	% assign DB collection prefix
	set_setting(mng_client:collection_prefix, NEEM_id),
	% load URDF files referred to in triple store
	urdf_init,
writeln(load_init_tf),
	% initialize position of each frame for tf publishing
	tf_tree:initial_transforms(InitialTransforms),
length(InitialTransforms,NInitialTransforms),
writeln(initial_transforms(NInitialTransforms)),
	forall(
		member([Ref,Frame,Pos,Rot],InitialTransforms),
		tf_plugin:tf_republish_set_pose(Frame,[Ref,Pos,Rot])
	),
	% publish object marker messages
	marker_plugin:republish.
