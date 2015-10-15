hello mike ?
<?php
try
{
  $m = new MongoClient();
}
catch( Exception $e )
{
  var_dump($e);
}

$collection = $m->selectCollection('sandbox', 'stuff');

$cursor = $collection->find();
foreach ($cursor as $doc) {
    var_dump($doc);
}
?>
