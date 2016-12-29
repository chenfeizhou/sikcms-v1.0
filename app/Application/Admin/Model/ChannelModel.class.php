<?php

// +----------------------------------------------------------------------
// | 思科cms  栏目模型
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.sikcms.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: zhijian.chen <1114526565@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Model;

use Common\Model\Model;

class ChannelModel extends \Think\Model {
    //自定验证
    protected $_validate = array(
        array('name', 'require', '栏目名称不能为空!'),
        array('template_id','require','缺少模板id参数!'),
        array('index_template', 'require', '封面模板不能为空!'),
        array('list_template', 'require', '列表模板不能为空!'),
        array('article_template', 'require', '文章模板不能为空!'),
        array('ishidden',array(0,1),'值的范围不正确！',0,'in'), // 判断是否在一个范围内
        array('ispart',array(0,1,2),"值的范围不正确！",0,'in') 

    );
    //array(填充字段,填充内容,[填充条件,附加规则]) 
    protected $_auto = array(
        array('ctime', 'time', 1, 'function'),
    );

    /**
     * 栏目下拉
     * @param int $parentid 父类ID
     * @param int $mode_id 模型ID
     */
    public function getChannelTree($parentid = 0, $page = 1,$rows = 20,$mode_id = null) {
        $order = "`sort` asc,`ctime` desc";
        $where = array('parentid' => $parentid,'ispart'=>array('neq',1));
        if($mode_id){
            $where['mode_id']=$mode_id;
        }
        $result = $this->where($where)->order($order)->page($page, $rows)->select();
        if (is_array($result)) {
            foreach ($result as &$arr) {
                $arr['children'] = $this->getChannelTree($arr['id']);
            }
        } else {
            $result = array();
        }
        return $result;
   
    }

    /**
     * 按父类ID查找子栏目
     * @param int $parentid
     */
    public function getChannel($parentid = 0, $with_self = 0) {
        $rows = C('LISTROWS');
        $parentid = intval($parentid);
        $result = $this->where(array('parentid' => $parentid))->order('sort asc')->limit(1000)->select();
        if (!is_array($result))
            $result = array();
        if ($with_self) {
            $result2[0] = $this->where(array('id' => $parentid))->find();
            $result = array_merge($result2, $result);
        }
        return $result;
    }

    /**
     * 栏目总数
     */
    public function getCount($parentid = 0) {
        return $this->where(array('parentid' => $parentid))->count();
    }

}
