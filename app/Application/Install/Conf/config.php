<?php
/**
 * 项目公共配置文件
 * 该文件请不要修改，如果要覆盖惯例配置的值，可在应用配置文件中设定和惯例不符的配置项
 * 配置名称大小写任意，系统会统一转换成小写
 * 所有配置参数都可以在生效前动态改变
 */
defined('THINK_PATH') or exit();
$conf = require(PROJECT_PATH."Common/Conf/config.php");
$version = require(PROJECT_PATH."Common/Conf/version.inc.php");
$array =  array(
    'URL_MODEL' => 0, // URL访问模式,可选参数0、1、2、3,代表以下四种模式：
    // 0 (普通模式); 1 (PATHINFO 模式); 2 (REWRITE  模式); 3 (兼容模式)  默认为PATHINFO 模式
    'TMPL_PARSE_STRING' => array(
     '__STATIC__' =>STATIC_PATH.'/install', //后台对应静态资源地址
     //  '__STATIC__' => './app/Static/', //静态资源地址
    ),
);

return array_merge($array,$conf,$version);
