<?php
// +----------------------------------------------------------------------
// | 思科cms 上传类
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.sikcms.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: zhijian.chen <1114526565@qq.com>
// +----------------------------------------------------------------------
namespace Admin\Controller;
use Common\Controller\AdminBase;
use Admin\Service\Uploads;

class UploadsController extends AdminBase{

    /**
     * 上传文件
     */
    public function upload(){
        $uploads = new Uploads();
        $msg = $uploads ->_upload();
        $this->ajaxReturn($msg);
    }
    /**
     * 上传文件
     */
    public function upfile(){
        
    }
    
}