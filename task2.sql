use snet;


select count(*) as num_messages, to_profile_id as id from messages where from_profile_id = 1 and to_profile_id in 
	(
		select target_profile_id from friend_requests where initiator_profile_id = 1 and status = 'approved'
			union
		select initiator_profile_id from friend_requests where target_profile_id = 1 and status = 'approved'
	) group by to_profile_id
	union
select count(*) as num_messages, from_profile_id as id from messages where to_profile_id = 1 and from_profile_id in 
	(
		select target_profile_id from friend_requests where initiator_profile_id = 1 and status = 'approved'
			union
		select initiator_profile_id from friend_requests where target_profile_id = 1 and status = 'approved'
	) group by from_profile_id
order by num_messages desc limit 1;




