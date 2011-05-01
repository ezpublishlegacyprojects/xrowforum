<?php

include_once ( 'kernel/common/template.php' );
include_once( 'lib/ezdb/classes/ezdb.php' );
require_once( 'kernel/common/i18n.php' );

$http = eZHTTPTool::instance();
$tpl = templateInit();

$Result = array();
$Result['left_menu'] = "design:admin/menu.tpl";
$Result['content'] = $tpl->fetch( "design:admin/permissions.tpl" );
$Result['path'] = array( array( 'url' => false,
                                'text' => ezi18n( 'extension/xrowforum', 'xrowForum permissions' ) ) );
    
?>