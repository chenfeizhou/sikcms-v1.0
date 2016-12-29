<?php

// +----------------------------------------------------------------------
// | 思科cms 后台软件模块
// +----------------------------------------------------------------------
// | Copyright (c) 2015-2016 http://www.sikcms.cn All rights reserved.
// +----------------------------------------------------------------------
// | Author: zhijian.chen <1114526565@qq.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;

use Common\Controller\AdminBase;


class SoftController extends AdminBase {

    //页码
    public $page = 1;
    //每页数
    public $rows = 10;
    //软件状态码
    public $status = array();
    //模型标识
    public $nid ='soft'; 
    //模型ID
    public $mode_id=6;
    

    //初始化
    public function _initialize() {
        parent::_initialize();
        $this->page = I('get.page', 1);
        $this->rows = C('LISTROWS');
        //文章状态对应文章表status字段
        $this->status = array(
            0 => array('text' => '草稿', 'color' => 'font-gray-dark'),
            1 => array('text' => '审核中', 'color' => 'font-yellow'),
            2 => array('text' => '审核通过', 'color' => 'font-green'),
            3 => array('text' => '回收站', 'color' => 'font-gray'));
    }

    /**
     * 列表
     */
    public function index() {
        $status = I('get.status', '');
        $channel_id = I('get.channel_id', '');
        $where = "";
        if (!empty($status) && $status != 'all') {
            $where['status'] = $status;
        }
        if (!empty($channel_id) && $channel_id != 'all') {
            $where['channel_id'] = array('eq', $channel_id);
        }
        $soft_db = D('Soft');
        $module_db = D('Module');
        //获取操作方法
        $action = $module_db->getInfoBynid($this->nid);
        $list = $soft_db->getSoftList($this->page, $where);
        $this->assign('action',$action);
        $this->assign('list', $list);
        $this->assign('page', $page);
        $this->assign('status', $this->status);
        $this->display('list');
    }

    /**
     * 添加
     */
    public function add() {
        if (IS_POST) {
            $soft_db = D('Soft');
            $soft_img_db = M('soft_imgs');
            $post = I('post.info');
            $data = array(
                'channel_id' => $post['parentid'],
                'soft_name' => $post['soft_name'],
                'status' => $post['status'],
                'listorder' => $post['sort'],
                'download'=>$post['download'],
                'demo_url'=>$post['demo_url'],
                'thumb' => $post['thumb'],

                'inputtime' => time(),
                'updatetime' => time()
            );
            $article_db->startTrans();
            $res = $article_db->add($data);
            if (!$res) {
                $article_db->rollback();
                $this->error('添加失败');
            }
            $article_data = array(
                'articles_id' => $res,
                'content' => htmlspecialchars($post['content'])
            );
            if (!$article_data_db->add($article_data)) {
                $article_db->rollback();
                $this->error('添加内容失败');
            }
            $article_db->commit();
            $res ? $this->success('添加成功', U('Articles/index')) : $this->error('添加失败');
        }
        $channel_db = D('Channel');
        $channel = $channel_db->getChannelTree(0, 1, 1000,$this->mode_id);
        $this->assign('channel', $channel);
        $this->assign('flag', $this->flag);
        $this->assign('status', $this->status);
        $this->display();
    }

    /**
     * 编辑
     */
    public function edit() {
        $article_db = D('articles');

        if (IS_POST) {
            $post = I('post.info');
            $data = array(
                'channel_id' => $post['parentid'],
                'title' => $post['title'],
                'status' => $post['status'],
                'listorder' => $post['sort'],
                'thumb' => $post['thumb'],
                'flag' => implode(',', $post['flag']),
                'inputtime' => time(),
                'updatetime' => time()
            );
            $article_db->startTrans();
            $article_id = intval($post['id']);
            $res = $article_db->where('id=' . $post['id'])->save($data);
            if (!$res) {
                $article_db->rollback();
                $this->error('修改失败');
            }
            $article_data = array(
                'content' => htmlspecialchars($post['content'])
            );
            $article_data_db = M('article_data');
            if (!$article_data_db->where("articles_id = $article_id")->save($article_data)) {
                $article_db->rollback();
                $this->error('添加内容失败');
            }
            $article_db->commit();
            $this->success('修改成功', U('Articles/index'));
        }
        $id = I('get.id');
        $info = $article_db->getInfo($id);
        $channel_db = D('Channel');
        $channel = $channel_db->getChannelTree(0, 1, 1000,$this->mode_id);
        $this->assign('channel', $channel);
        $this->assign('id', $id);
        $this->assign('info', $info);
        $this->assign('status', $this->status);
        $this->display();
    }

    /**
     * 删除
     */
    public function delete() {
        $ids = I('post.ids', 0);
        $articles_db = D('articles');
        $res = $articles_db->where(array('id' => array('in', $ids)))->delete();
        $res ? $this->success('删除成功') : $this->error('删除失败');
    }

}
