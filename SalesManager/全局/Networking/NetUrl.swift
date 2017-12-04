//
//  NetUrl.swift
//  UnionWorker
//
//  Created by Linus on 2017/8/1.
//  Copyright © 2017年 Linus. All rights reserved.
//

import UIKit

class NetUrl: NSObject {
    
    //phone：手机；password：密码；securityCode验证码；terminal：登录终端
    static let REGISTER_POST = "/wechat/userInfo/register"
    
    //phone: 手机;
    static let SEND_SECURITY_POST = "/wechat/userInfo/sendSecurityCode"
    
    //支付密码验证码
    static let SEND_PAY_SECURITY = "/wechat/userInfo/sendPaySecurityCode"
    
    //phon:手机；securityCode验证码;terminal:登录终端
    static let FORGET_PASSWORD_POST = "/wechat/userInfo/forgetPassword"
    
    //phone: 手机
    static let PHONE_ONLY_POST = "/wechat/userInfo/phoneOnly"
    
    //password：密码；token：身份令牌
    static let RESET_PASSWORD_POST = "/wechat/userInfo/resetPassword"
    
    static let RESET_PAY_PASSWORD_POST = "/wechat/wallet/resetPayPassword"
    
    //phone: 手机; password: 密码; terminal: 登录终端
    static let LOGIN_POST = "/wechat/userInfo/login"
    
    //token: 身份令牌
    static let LOGIN_BY_TOKEN = "/app/us"
    //上传头像
    static let UP_LOAD_HEAD_IMAGE = "/wechat/userInfo/modifyHeadImage"
    //修改昵称
    static let MODIFY_NICK_NAME = "/wechat/userInfo/modifyNickname"
    //修改登录密码
    static let MODIFY_LOGIN_PASSWORD = "/wechat/userInfo/modifyPassword"
    //设置支付密码
    static let SET_PAY_PASSWORD = "/wechat/wallet/setPayPassword"
    //设置免密支付
    static let SET_NO_PASSWORD = "/wechat/wallet/setNoPass"
    //获取是否开启免密支付
    static let HAS_NO_PASSWORD = "/wechat/wallet/hasPass"
    //获取优惠券列表
    static let TICKET_MARKET_LIST = "/external/ticket/ticketMarketList"
    //领取优惠券
    static let TICKET_DRAW = "/external/ticket/ticketDraw"
    //红包list
    static let RED_PACKAGE_LIST = "/external/redPkg/redPkgList"
    
    //修改支付密码
    static let MODIFY_PAY_PASSWORD = "/wechat/wallet/modifyPayPassword"
    
    //支付密码验证
    static let PAY_PASSWORD_VALIDATE = "/wechat/wallet/payValidate"
    
    //忘记支付密码
    static let FORGET_PAY_PASSWORD = "/wechat/wallet/forgetPayPassword"
    
    //查询最新第一条消息
    static let MESSAGE_LIST_FIRST = "/external/message/newFirstMsgList"
    
    //未读消息统计 String phone,String token
    static let UN_READ_MESSAGE_COUNT = "/external/message/unreadMsgCount"
    
    //批量删除消息 String phone,String token,String ids(多id以逗号分割)
    static let DELETE_MESSAGE = "/external/message/deleteMsgs"
    
    //已读状态修改 String phone,String token,int msgId,int readStatus (1:已读)
    static let UPDATE_READ_MESSAGE = "/external/message/updateInstationMsg"
    
    //获得消息列表 Int type,Int pageNo,Int pageSize, String token, String phone
    static let MESSAGE_LIST_BY_TYPE = "/external/message/instationMsgList"
    
    //下单 String phone,String token,String channel, (33-充值32-便民缴费)Integer amount,String desc
    static let PAY_ORDER = "/external/pay/placeAnOrder"
    //微信下单 String phone,String token,String orderNo，Integer payFlag（2-微信4-威富通）
    static let PAY_WECHAT_ORDER = "/external/pay/paymentOrderWechat"
    
    //获取余额 token
    static let GET_BALANCE = "/wechat/userInfo/queryBalance"
    
    //web扫码支付
    static let SWEEP_CODE = "/tradeUnion/app/app-h5/template/puhui-pay.html"
    //拼团
    static let GROUP_BUY = "/tradeUnion/app/app-h5/template/group/index.html"
    
    //京东
    static let JD_WEB = "http://114.55.178.237:9062/jd/resource/index.html"
    
    //卷列表 String phone,String token,String state(-1过期，0可用，1已用),Integer pageNo, Integer pageSize
    static let MY_COUPONS_LIST = "/external/ticket/userTicketList"
    
    //绑定银行卡
    static let BANK_BANG_DING = "/tradeUnion/app/template/remit-member/bind-bankCard.html"
    
    static let BANK_GUAN_LI = "/tradeUnion/app/template/remit-member/bank-card.html"
    
    //动态
    static let DONG_TAI = "/tradeUnion/app/template/labor-server/staff-mien.html"
    
    //平台介绍
    static let PINGTAI_JIESHAO = "/tradeUnion/app/template/remit-member/platform-introduce.html"
    
    //关于商通
    static let ABOUT_SHANGTONG = "/tradeUnion/app/template/remit-member/service-provider-introduce.html"
    
    //阳光福利
    static let SUM_WALFARE = "/tradeUnion/app/template/remit-member/sunshine-welfare-introduce.html"
    
    //活动全路径
    static let ACTIVITY_FULL_PASS = Utils.getGlobalUrl() + "/tradeUnion/app/template/sub-life"
    
    //商超百货
    static let SHANGCHAO_BAIHUO = "/nearby-stroe-market.html"
    //餐饮美食 
    static let CANYING_MEISHI = "/nearby-stroe-food.html"
    //医疗服务  
    static let YILIAO_FUWU = "/nearby-stroe-care.html"
    //生活服务 
    static let SHENGHUO_FUWU = "/nearby-stroe-life.html"
    //休闲娱乐  
    static let XIUXIAN_YULE = "/nearby-stroe-entertainment.html"
    //专卖门店  
    static let ZHUANMAI_MENDIAN = "/nearby-stroe-pro.html"
    //旅游票务  
    static let LVYOU_PIAOWU = "/nearby-stroe-ticket.html"
    //更多商家
    static let GENGDUO_SHANGJIA = "/nearby-stroe.html"
    
    //注册协议
    static let REGISTER_TEXT = "/tradeUnion/app/template/remit-member/user-agreement.html"
    
    //充值协议
    static let CHARGE_TEXT = "/tradeUnion/app/template/remit-member/recharge-agreement.html"
    
    //普惠活动
    static let PUHUI_HUODONG = "/tradeUnion/app/template/sub-life/beautiful-life.html"
    
    //手机充值
    static let PHONE_CHARGE = "/tradeUnion/app/template/sub-life/phone-recharge.html"
    //意见反馈
    static let FEED_BACK = "/tradeUnion/app/template/remit-member/interaction.html"
    
    
    //申请入会
    static let APPLY_MEMBERSHIP = "/tradeUnion/app/template/remit-member/enter-union-apply.html"
    
    //广告
    static let MALL_CAROUSE_LIST = "/wechat/mall/getCarouselList"
    
    //账单
    static let PUHUI_WALLET_LIST = "/wechat/userInfo/queryTransDetail"
    
    //获取是否绑定银行卡
    static let HAS_BANK_CARD = "/wechat/wallet/getCardInfo"
    
    //推送注册
    static let REGISTER_DEVICE_CODE = "/wechat/userInfo/saveAppToken"
    
    //专项资金
    static let ZHUANXIANG_MONEY_LIST = "/external/uf/fetchSpecialAcctNo"
    
    //资金账单
    static let SPECAIL_BILL = "/external/uf/querySpecialBill"
    
    //和信通充值
    static let HEXINPASS_CHARGE = "/external/uf/hxCharge"
    
    //专项资金未读消息
    static let SPECIAL_AMT_ARRIVE = "/external/message/specialAmtArrive"
    
    //主页接口
    static let APP_INDEX = "/app/index"
    
    //获取附近高分门店
    static let  NEAR_BY_MERCHANTLIST = "/wechat/mall/nearbyMerchantLevelList"
    
    //验证身份证号获取手机号
    static let CHECK_ID_CARD_GET_PHONE = "/wechat/userInfo/queryPhone"
    
    //验证身份证与登录密码
    static let CHECK_ID_CARD_AND_PWD = "/wechat/userInfo/validateIdCardPwd"
    
    //更换手机号
    static let CHANGE_PHONE = "/wechat/userInfo/changePhone"
    
    //查询劳保资金
    static let GET_LAOBAO_BALANCE = "/external/uf/eAccountQuery"
    
    //资金账单
    static let QUERY_DRAW_DETAIL = "/external/uf/querydrawDetail"
    
    //账单记录
    static let EACCT_CHARGE_DETAIL = "/external/uf/eacctChargeDetail"
    
 
    
}
