<?php


class Censoring
{

    function Censoring()
    {
        $this->Operators = array( 'censoring' );
    }

    function operatorList()
    {
        return array( 'censoring' );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array( 'censoring' => array ());
    }

    function modify( &$tpl, &$operatorName, &$operatorParameters, &$rootNamespace, &$currentNamespace, &$operatorValue, &$namedParameters )
    {
		$xrowForumINI = eZINI::instance( 'xrowforum.ini' );
		$censoringlist = $xrowForumINI->group( 'Censoring', 'CensoringList' );
		$temp_val = $operatorValue;
		foreach ( $censoringlist["CensoringList"] as $key => $censorword )
		{
			$temp_val  = str_replace($key, $censorword, $temp_val);
		}
		$operatorValue = $temp_val;
    }
}

?>