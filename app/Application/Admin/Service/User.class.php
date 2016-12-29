<?php

/*
 * 思科cms 后台用户相关
 * @author zhijian.chen
 * @email 1114526565@qq.com
 * @date 2016/3/11
 *
 */

namespace Admin\Service;

class User {

    //存储用户uid的Key
    const userUidKey = 'klccms_userid';
    //超级管理员角色id
    const administratorRoleId = 1;

    //当前登录会员详细信息
    private static $userInfo = array();

    /**
     * 连接后台用户服务
     * @staticvar \Admin\Service\Cache $systemHandier
     * @return \Admin\Service\Cache
     */
    static public function getInstance() {
        static $handier = NULL;
        if (empty($handier)) {
            $handier = new User();
        }
        return $handier;
    }

    /*
     * 检查用户是否已登录
     * @return boolean 失败返回false 成功返回用户基本信息
     */

    public function isLogin() {
        //加密算法
        $userId = \Libs\Util\Encrypt::authcode(session(self::userUidKey), 'DECODE');
        if (empty($userId)) {
            return false;
        }
        return (int) $userId;
    }

    //登录后台
    public function login($identifier, $password) {
        if (empty($identifier) || empty($password)) {
            return false;
        }
        //验证
        $userInfo = $this->getUserInfo($identifier, $password);
        if (false == $userInfo) {
            //记录登录日志
            $this->record($identifier,$password,0);
            return false;
        }
        //记录登录日志
        $this->record($identifier, $password, 1);
        //注册登录状态 session加密
        $this->registerLogin($userInfo);
        return true;
    }

    /**
     * 魔术方法
     * @param type $name
     * @return null
     */
    public function __get($name) {
        //缓存获取
        if (isset(self::$userInfo[$name])) {
            return self::$userInfo[$name];
        } else {
            $userInfo = $this->getInfo();
            if (!empty($userInfo)) {
                return $userInfo[$name];
            }
        }
        return null;
    }

    public function getInfo() {
        if (empty(self::$userInfo)) {
            self::$userInfo = $this->getUserInfo($this->isLogin());
        }
        return !empty(self::$userInfo) ? self::$userInfo : false;
    }

    /*
     * 检查是否为管理员
     * @reutrn boolean
     */

    public function isAdministrator() {
        $userInfo = $this->getInfo();
        if (!empty($userInfo) && $userInfo['roleid'] == self::administratorRoleId) {
            return true;
        }
        return false;
    }

    /*
     * 注销登录状态
     * @return boolean
     */

    public function logout() {
        session(null);
        return true;
    }

    /*
     * 注册登录记录状态
     * @param array $userInfo 用户信息
     */

    private function registerLogin(array $userInfo) {
        
        //写入session
        session(self::userUidKey, \Libs\Util\Encrypt::authcode((int) $userInfo['userid'], ''));
        //更新状态
        D('Admin/User')->loginStatus((int) $userInfo['userid']);
        
        //注册权限
         Access::saveAccessList((int) $userInfo['userid']);
    }

    /**
     * 获取用户信息
     * @param type $identifier 用户名或者用户ID
     * @return boolean|array
     */
    private function getUserInfo($identifier, $passwrod = NULL) {
        if (empty($identifier)) {
            return false;
        }
        return D('Admin/User')->getUserInfo($identifier, $passwrod);
    }

    /**
     * 记录登录日志
     * @param type $identifier 登录方式,uid,username
     * @param type $password 密码
     * @param type $status
     */
    private function record($identifier, $password, $status = 0) {
        //登录日志
        D('Admin/Loginlog')->addLoginLogs(array(
            'username'=>$identifier,
            'status'=>$status,
            'password'=>$status?'密码保密':$password,
            'info'=>is_int($identifier)?'用户ID登录':'用户名登录',
        ));
    }

}
