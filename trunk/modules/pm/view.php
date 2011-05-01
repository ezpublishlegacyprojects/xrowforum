<?php

include_once ( 'kernel/common/template.php' );
include_once( 'lib/ezdb/classes/ezdb.php' );
require_once( 'kernel/common/i18n.php' );

$db = eZDB::instance();
$tpl = templateInit();
$Module = $Params['Module'];
$http = eZHTTPTool::instance();
$user = eZUser::currentUser();
$namedParameters = $Module->NamedParameters;
$msg_id = $namedParameters['messageID'];

if($msg_id != "" AND is_numeric($msg_id))
{
	$msg = $db->arrayQuery("SELECT * FROM xrowforum_pm_messages where owner_id = $user->ContentObjectID and msg_id = $msg_id;");
}

if(count($msg) == 1)
{
	$tpl->setVariable( 'message', $msg );
}
else
{
	return $Module->handleError( 1, 'kernel' );
}

$Result = array();
$Result['content'] = $tpl->fetch( 'design:pm/view_pm.tpl' );
$Result['path'] = array( array( 'url' => false,
                                'text' => ezi18n( 'extension/xrowpm', 'PM - view message' ) ) );
    
?>