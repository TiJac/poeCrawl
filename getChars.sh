mkdir -p poeCrawl
while read p; do
  curl --cookie "POESESSID=$1" https://www.pathofexile.com/character-window/get-items?character=$p | jq --compact-output '{eins:[.items[].sockets], zwei:[.items[]?.socketedItems]}' | jq --compact-output '.eins as $sockets | .zwei as $skills | reduce range(0; $skills|length) as $i ([]; . + [{ "socketgroups": [$sockets[$i][]?.group], "skills": [$skills[$i][]?.typeLine] }])' > ./poeCrawl/$p.skills.json
done 
