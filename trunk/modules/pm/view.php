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
$path_text = "Inbox";
$path_url = "inbox";

if($msg_id != "" AND is_numeric($msg_id))
{
	$msg = $db->arrayQuery("SELECT * FROM xrowforum_pm_messages where owner_id = $user->ContentObjectID and msg_id = $msg_id;");
}

if(count($msg) == 1)
{
	$tpl->setVariable( 'message', $msg );
	if($msg[0]["sender"] == $user->ContentObjectID)
	{
		$path_text = "Outbox";
		$path_url = "outbox";
	}
}
else
{
	return $Module->handleError( 1, 'kernel' );
}

$Result = array();
$Result['content'] = $tpl->fetch( 'design:pm/view_pm.tpl' );
$Result['path'] = array( array( 'url' => "/",
                                'text' => ezi18n( 'extension/dropcalc', 'Home' ) ),
						 array( 'url' => "/pm/" . $path_url,
                                'text' => ezi18n( 'extension/dropcalc', $path_text ) ),
						 array( 'url' => false,
                                'text' => ezi18n( 'extension/xrowpm', 'view message' ) ) );
    
?>