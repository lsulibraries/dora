#!/bin/bash

this=$1

prev=$((this - 1))

echo "prev = $prev and this = $this"

service tomcat7 stop
echo "sleeping 5"
sleep 5

mv /usr/local/solr/collection1/data /tmp/solr-data.$prev
service tomcat7 start
echo "sleeping 15 so tomcat can wake up before the reindex"
sleep 15

echo "starting to rebuild the index with a cURL request to the gsearch api..."
/usr/bin/time -o /tmp/time.$this -f "%e" curl -u fedoraAdmin:fedoraAdmin "http://localhost:8080/fedoragsearch/rest?operation=updateIndex&action=fromFoxmlFiles&value=" | tee -a /tmp/reindex.log.$this
echo "done rebuilding the index"

echo "sleeping 5 for no real reason"
sleep 5

seconds=$(cat /tmp/time.$this)
echo "Time $seconds"

datasize=$(du -s /usr/local/solr/collection1/data)
echo "size $datasize"

fieldcount=$(curl 'http://localhost:8080/solr/select?q=*:*&wt=csv&rows=0&facet' | tr , '\n'  | sort | wc -l)
echo "fields $fieldcount"

curl 'http://localhost:8080/solr/select?q=*:*&wt=csv&rows=0&facet' | tr , '\n'  | sort > /tmp/solr-fields.$this

echo "fieldlist is at /tmp/solr-fields.$this"
