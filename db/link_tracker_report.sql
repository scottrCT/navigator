select link, count(id) 
from link_trackers
 where created_at between date('2010-08-01') AND date('2010-11-01') group by link