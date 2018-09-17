# Alipay_AntForest

ios支付宝，一键收取蚂蚁森林全部好友能量，一键帮好友收取能量，定时收取能量

代码仅供学习交流，感谢您 帮忙在右上角 点个“⭐️”，非常感谢

本文代码是在[iOS支付宝蚂蚁森林能量收取助手](https://github.com/hackxhj/alipayForestTweak)源代码基础上做的新增和扩展。

功能：
在ios版支付宝的蚂蚁森林中，一键实现自动筛选全部好友并收取好友能量。


## 新增内容：

- 1、遍历全部好友，筛选出可收取能量的好友和可被帮助收取能量的好友。

好友排名数组：
```
friendRanking : [
		{
		realName : 0,
		forestUser : 0,
		treeAmount : 10,
		rank : 1,
		canCollectLaterTime : -1,
		userId : 2088xxxxxxxx61111,
		canCollectEnergy : 0,
		collectableBubbleCount : 0,
		energySummation : 216671,
		headPortrait : ,
		displayName : ,
		canHelpCollect : 0
	}]
```
其中canCollectEnergy为1时，可收取；canHelpCollect为1时，可被帮助收取。


- 2、遍历单个好友的全部能量，筛选出能被收取或能被帮助收取的能量。

好友的能量气泡数组：
```
bubbles : [
		{
		collectStatus : INSUFFICIENT,		//收取状态，INSUFFICIENT 不足的，AVAILABLE 可收取，
		userId : 2088xxxxxxxx17384,			//用户的id
		canHelpCollect : 1,					//是否可被帮助收取
		id : 76012195,						//气泡的id
		produceTime : 1536934343000,
		fullEnergy : 52,
		overTime : 1537193543000,
		business : {
		nightIconUrl : https://zos.alipayobjects.com/rmsportal/GydawUvGZiOzxMM.png,
		id : 2,
		bizType : ditie,
		smallIconDisplayName : 地铁出行,
		bigIconDisplayName : 地铁出行,
		dayIconUrl : https://zos.alipayobjects.com/rmsportal/ulnllVtPwKlmuEb.png
	}]
```




- 3、根据当前能量的collectStatus为AVAILABLE则可被收取，执行收取；根据当前能量的canHelpCollect为1则可被帮助收取，执行帮助收取。



