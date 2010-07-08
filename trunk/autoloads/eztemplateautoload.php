<?php

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/getnewposts.php',
                                    'class' => 'getNewPosts',
                                    'operator_names' => array( 'like_operator' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/deflagsubtree.php',
                                    'class' => 'deflagSubtree',
                                    'operator_names' => array( 'deflag_subtree' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/counter.php',
                                    'class' => 'topicViewCounter',
                                    'operator_names' => array( 'read_count','write_count' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/rank.php',
                                    'class' => 'requestUserRank',
                                    'operator_names' => array( 'request_rank' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/bbcodetemplateoperator.php',
                                    'class' => 'BBCodeTemplateOperator',
                                    'operator_names' => array( 'bbcode2xhtml', 'xhtml2bbcode' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/post_topic_count.php',
                                    'class' => 'ObjectByIDOperator',
                                    'operator_names' => array( 'object_by_id' ) );

$eZTemplateOperatorArray[] = array( 'script' => 'extension/xrowforum/autoloads/operator_merge.php',
                                    'class' => 'OperatorMerge',
                                    'operator_names' => array( 'operator_merge' ) );

?>   