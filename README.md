# MSAnimationDemo
仿写[A-GUIDE-TO-iOS-ANIMATION](https://github.com/KittenYang/A-GUIDE-TO-iOS-ANIMATION)

# MSQQbubble 
封装成一个单独的view 可以在tableViewCell中使用，其中MSBadgeView 可单独作为没有交互功能的未读消息view使用
![image](https://github.com/liwenDeng/MSAnimationDemo/blob/master/MSQQBubbleDemo/QQbubble.gif)

使用方法：
````
        MSBubbleView *bView = [[MSBubbleView alloc]initWithFrame:CGRectMake(200, 11, 60, 30) bubbleColor:[UIColor redColor] titleColor:[UIColor whiteColor] fontSize:18.0 alignMode:(MSBadgeViewAlignRight)];
        [cell addSubview:bView];
        bView.seperateScale = 0.3;
        bView.badge = [NSString stringWithFormat:@"%ld",indexPath.row];
````

-可以自定义气泡的对齐方式

-根据字体大小自适应气泡大小

-气泡爆炸消失时的动画采用gif实现,可以提供自定义的gif替换默认的爆炸消失动画
````
//爆炸消失动画在MSBubbleAnimationView.m 中定义
#pragma mark -layLoading
- (NSMutableArray *)destoryImages {
    if (!_destoryImages) {
        _destoryImages = [NSMutableArray array];
        for (int i = 1; i < 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
            [_destoryImages addObject:image];
        }
    }
    return _destoryImages;
}
````

-使用[圆角优化](https://github.com/raozhizhen/JMRoundedCorner)来设置view的圆角（其实对view影响不大）
````
        //设置圆角
//        self.layer.backgroundColor = bubbleColor.CGColor;
//        self.layer.cornerRadius = _diameter/2.0;
        //对圆角进行优化，采用下列方法设置圆角 https://github.com/raozhizhen/JMRoundedCorner
        [self setJMRadius:(JMRadiusMake(_diameter/2.0, _diameter/2.0, _diameter/2.0, _diameter/2.0)) withBackgroundColor:bubbleColor];
        [self addSubview:_bubbleLabel];
````


