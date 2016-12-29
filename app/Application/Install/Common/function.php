<?php

/*
 * 快乐筹cms
 * @author zhijian.chen
 * @email 1114526565@qq.com
 * @date 2016/3/16
 *
 */

function sql_execute($sql,$tablepre){
      $sqls = sql_split($sql, $tablepre);
    if (is_array($sqls)) {
        foreach ($sqls as $sql) {
            if (trim($sql) != '') {
                mysql_query($sql);
            }
        }
    } else {
        mysql_query($sqls);
    }
    return true;
}

function sql_split($sql, $tablepre) {
    if ($tablepre != "shuipfcms_")
        $sql = str_replace("shuipfcms_", $tablepre, $sql);
    $sql = preg_replace("/TYPE=(InnoDB|MyISAM|MEMORY)( DEFAULT CHARSET=[^; ]+)?/", "ENGINE=\\1 DEFAULT CHARSET=utf8", $sql);

    if ($r_tablepre != $s_tablepre)
        $sql = str_replace($s_tablepre, $r_tablepre, $sql);
    $sql = str_replace("\r", "\n", $sql);
    $ret = array();
    $num = 0;
    $queriesarray = explode(";\n", trim($sql));
    unset($sql);
    foreach ($queriesarray as $query) {
        $ret[$num] = '';
        $queries = explode("\n", trim($query));
        $queries = array_filter($queries);
        foreach ($queries as $query) {
            $str1 = substr($query, 0, 1);
            if ($str1 != '#' && $str1 != '-')
                $ret[$num] .= $query;
        }
        $num++;
    }
    return $ret;
}

