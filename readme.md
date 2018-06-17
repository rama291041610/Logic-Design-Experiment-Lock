### 电子密码锁

#### 实验环境： Windows10

#### 实验软件： Vivado 2018.1

#### 开发板： ARTIX 7

##### 实验要求:

1. 设计一个开锁密码至少为4位数字（或更多）的密码锁。
2. 当开锁按扭开关（可设置8位或更多，其中只有4位有效，其余位为虚设）的输入代码等于所设密码时启动开锁控制电路，并且用绿灯亮、红灯灭表示开锁状态。
3. 从第一个按扭触动后的5秒内若未能将锁打开，则电路自动复位并发出报警信号，同时用绿灯灭、红灯亮表示关锁状态。 

#### 实现功能：

1. 采用MOD10计数器读入。
2. 初次使用需设置密码，在开锁状态下可修改密码。
3. 使用四个七段数码管实时显示输入密码，非输入状态自动复位。
4. 使用一个七段管显示5秒倒计时，并判断是否超时，超时自动复位，并停止输入。
5. 有一个reset键，可使输入归零。
6. 使用一个led表示锁的状态，绿灯亮代表开锁状态，灭代表关锁状态。

##### 详细见代码注释。