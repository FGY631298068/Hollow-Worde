//
//  Created by 易龙天  on 2017/11/23.
//  杀之后阿拉斯加地方了；爱看；世纪东方；啊实打实了贷款就发了；斯柯达
//  Copyright © 2017年 宫巧霞. All rights reserved.
//


//woshiyige xoaniuren
#import "GoodsDetailVC.h"
#import "AddressPickerView.h"
#import "GoodsVC.h"
#import "DetailVC.h"
#import "AppraiseVC.h"

@interface GoodsDetailVC ()<AddressPickerViewDelegate,UIScrollViewDelegate>{
    UIView *aview;
    UIButton *goodsButton;
    UIButton *detailButton;
    UIButton *appraiseButton;
//    UIScrollView *backScrollview;
    UIView *redLine;
    UIView *downView;
    UIView *tipView;
    UIView *alphaView;
    UILabel *number;
    
}
@property (nonatomic ,strong) GoodsVC  *thirdVC;
@property (nonatomic ,strong) DetailVC  *firstVC;
@property (nonatomic ,strong) AppraiseVC *secondVC;
@property (nonatomic ,strong) UIViewController *currentVC;
@property (nonatomic ,strong) UIScrollView *backScrollview;  //  顶部滚动视图
@property (nonatomic ,strong) NSArray *headArray;
@property (nonatomic ,strong) AddressPickerView * pickerView;
@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationHeaderView];
    
    self.backScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight - 64)];
    self.backScrollview.delegate = self;
    self.backScrollview.bounces=NO;
    self.backScrollview.showsHorizontalScrollIndicator = NO;
    self.backScrollview.pagingEnabled=YES;
    self.backScrollview.contentSize = CGSizeMake(MainScreenWidth * 3, self.backScrollview.frame.size.height);
    [self.view addSubview:self.backScrollview];
    
    aview = [[UIView alloc] initWithFrame:CGRectMake((MainScreenWidth - 200) / 2, 30, 200, 30)];
    [navigationHeaderView addSubview:aview];
    self.headArray = @[@"商品",@"详情",@"评价"];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(MainScreenWidth - 20 -40, 30, 40, 20)];
    [btn setTitle:@"地区" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textColor = [UIColor blackColor];
    [btn addTarget: self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:btn];
    
    CGFloat w = 200 / 3;
    goodsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, w, 30)];
     goodsButton.tag = 100;
    [goodsButton setTitle:@"商品" forState:UIControlStateNormal];
    [goodsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [goodsButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    goodsButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [goodsButton addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:goodsButton];
    
    detailButton = [[UIButton alloc] initWithFrame:CGRectMake(w, 0, w, 30)];
    detailButton.tag = 101;
    [detailButton setTitle:@"详情" forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [detailButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    detailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [detailButton addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:detailButton];
    
    appraiseButton = [[UIButton alloc] initWithFrame:CGRectMake(w * 2, 0, w, 30)];
    appraiseButton.tag = 102;
    [appraiseButton setTitle:@"评价" forState:UIControlStateNormal];
    [appraiseButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [appraiseButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    appraiseButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [appraiseButton addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:appraiseButton];
    
    redLine = [[UIView alloc] initWithFrame:CGRectMake((w - 20) / 2, 28, 20, 2)];
    redLine.backgroundColor = [UIColor redColor];
    redLine.center = CGPointMake(goodsButton.center.x, 29);
    redLine.bounds = CGRectMake(0, 0, 28, 2);
    [aview addSubview:redLine];
    
    
    [self.view addSubview:self.pickerView];
    [self setDownView];
    
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
     [self setviewControllerUI];
}

#pragma mark--添加子控制器
//-(void)addChildViewController:(UIViewController *)childController{
//    NSInteger index = self.backScrollview.contentOffset.x / MainScreenWidth;
//    UIViewController *childVc = self.childViewControllers[index];
//
//    if (childVc.view.superview) return; //判断添加就不用再添加了
//    childVc.view.frame = CGRectMake(index * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height);
//    [self.backScrollview addSubview:childVc.view];
//}

-(void)setviewControllerUI{
//    GoodsVC *goods = [[GoodsVC alloc] init];
//    goods.view.frame = CGRectMake(0 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height);
//
////    [self addChildViewController:goods];
//    [self.backScrollview addSubview:goods.view];
//
//    DetailVC *detail = [[DetailVC alloc] init];
//    detail.view.frame = CGRectMake(1 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height);
////    [self addChildViewController:detail];
//    [self.backScrollview addSubview:detail.view];
//
//    AppraiseVC *appraise = [[AppraiseVC alloc] init];
//    appraise.view.frame = CGRectMake(2 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height);
////    [self addChildViewController:appraise];
//    [self.backScrollview addSubview:appraise.view];
    
    self.firstVC = [[DetailVC alloc] init];
    [self.firstVC.view setFrame: CGRectMake(0 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height - 49)];
    [self addChildViewController:_firstVC];
    
    self.secondVC = [[AppraiseVC alloc] init];
    [self.secondVC.view setFrame: CGRectMake(1 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height - 49)];
    
    self.thirdVC = [[GoodsVC alloc] init];
    [self.thirdVC.view setFrame: CGRectMake(2 * MainScreenWidth, 0, MainScreenWidth, self.backScrollview.frame.size.height - 49)];
    
    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
    [_backScrollview addSubview:self.firstVC.view];
    self.currentVC = self.firstVC;
    
}

- (void)didClickHeadButtonAction:(UIButton *)button
{
    //  点击处于当前页面的按钮,直接跳出
    if ((self.currentVC == self.firstVC && button.tag == 100)||(self.currentVC == self.secondVC && button.tag == 101.)) {
        return;
    }else{
        
        //  展示2个,其余一样,自行补全噢
        switch (button.tag) {
            case 100:
                [self replaceController:self.currentVC newController:self.firstVC];
                break;
            case 101:
                [self replaceController:self.currentVC newController:self.secondVC];
                break;
            case 102:
                [self replaceController:self.currentVC newController:self.thirdVC];
                break;
            default:
                break;
        }
        //修改线的位置
        
        [UIView animateWithDuration:0.5 animations:^{
            redLine.center = CGPointMake(button.center.x, 29);
        }];
        
    }
    
}

-(void)setDownView{
    downView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 50, MainScreenWidth, 50)];
    downView.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0];
    [self.view addSubview:downView];
    
    UIButton *kefuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [kefuButton addTarget:self action:@selector(kefuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:kefuButton];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((kefuButton.frame.size.width - 15) / 2, 10, 15, 15)];
    img.backgroundColor = [UIColor redColor];
    [kefuButton addSubview:img];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 25 + 5, 50, 15)];
    label.text = @"客服";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [kefuButton addSubview:label];
    
    UIButton *shoppCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
    [downView addSubview:shoppCarBtn];
    
    UIImageView *imgCar = [[UIImageView alloc] initWithFrame:CGRectMake((shoppCarBtn.frame.size.width - 15) / 2, 10, 15, 15)];
    imgCar.backgroundColor = [UIColor redColor];
    [shoppCarBtn addSubview:imgCar];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 25 + 5, 50, 15)];
    label2.text = @"购物车";
    label2.font = [UIFont systemFontOfSize:13];
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [shoppCarBtn addSubview:label2];
    
    CGFloat w = (MainScreenWidth - 100) / 2;
    UIButton *buyBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, w, 50)];
    buyBtn.backgroundColor = [UIColor redColor];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [buyBtn addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:buyBtn];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(100 + w, 0, w, 50)];
    addBtn.backgroundColor = [UIColor orangeColor];
    [addBtn setTitle:@"添加购物车" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [addBtn addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:addBtn];
}

-(void)kefuButtonClick{
    
    
}

-(void)buyButtonClick{
    alphaView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
    alphaView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView beginAnimations:@"open" context:nil];
    [UIView setAnimationDuration:0.5];
    
    [self setTipView];
    [UIView commitAnimations];
    
}

-(void)addButtonClick{
//    tipView = [[UIView alloc] initWithFrame:CGRectMake(0, MainScreenHeight, MainScreenWidth, 200)];
//    [UIView beginAnimations:@"open" context:nil];
//    [UIView setAnimationDuration:1];
//    tipView.frame = CGRectMake(0, (MainScreenHeight - 200), MainScreenWidth, 200);
//    tipView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:tipView];
//     [UIView commitAnimations];
//
//    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
//    img.backgroundColor = [UIColor redColor];
//    [tipView addSubview:img];
//
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60 + 10, 10, MainScreenWidth - 70 - 40, 40)];
//    title.text = @"南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚";
//    title.font = [UIFont systemFontOfSize:14];
//    title.textColor = [UIColor blackColor];
//    [tipView addSubview:title];
//
//    UILabel *priseLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + 10, 10 + 40, MainScreenWidth - 70 - 40, 40)];
//    priseLabel.text = [NSString stringWithFormat:@"￥ %@",@"55.00"];
//    priseLabel.font = [UIFont systemFontOfSize:14];
//    priseLabel.textColor = [UIColor redColor];
//    [tipView addSubview:priseLabel];
//
//    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((MainScreenWidth - 30), 10, 20, 20)];
//    [closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    closeBtn.backgroundColor = [UIColor redColor];
//    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [tipView addSubview:closeBtn];
    
    
    alphaView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, MainScreenHeight);
    alphaView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView beginAnimations:@"open" context:nil];
    [UIView setAnimationDuration:0.5];
   
    [self setTipView];
    [UIView commitAnimations];
   
    
}

-(void)setTipView{
    
    alphaView.frame = CGRectMake(0, 0, MainScreenWidth, MainScreenHeight);
//    alphaView.alpha = 0.1;
    [self.view addSubview:alphaView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, (alphaView.frame.size.height - 200), MainScreenWidth ,200)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [alphaView addSubview:whiteView];
    
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
    img.backgroundColor = [UIColor redColor];
    [whiteView addSubview:img];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60 + 10, 10, MainScreenWidth - 70 - 40, 40)];
    title.text = @"南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚南非进口红心柚";
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor blackColor];
    [whiteView addSubview:title];
    
    UILabel *priseLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 + 10, 10 + 40, MainScreenWidth - 70 - 40, 40)];
    priseLabel.text = [NSString stringWithFormat:@"￥ %@",@"55.00"];
    priseLabel.font = [UIFont systemFontOfSize:14];
    priseLabel.textColor = [UIColor redColor];
    [whiteView addSubview:priseLabel];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake((MainScreenWidth - 30), 10, 20, 20)];
    [closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    closeBtn.backgroundColor = [UIColor redColor];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:closeBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 80, 15)];
    label.text = @"购买数量";
    label.textColor = [UIColor lightGrayColor];
    [whiteView addSubview:label];
    //减号
    UIButton *minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainScreenWidth - 20 - 40 - 20 - 20, 170, 20, 20)];
    minusBtn.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0];
    [minusBtn addTarget:self action:@selector(minusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [minusBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [whiteView addSubview:minusBtn];
    
    number = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenWidth - 20 - 20 - 40, 170, 40, 20)];
    number.textColor = [UIColor blackColor];
    number.text = @"1";
    number.font = [UIFont systemFontOfSize:12];
    number.textAlignment = NSTextAlignmentCenter;
    [whiteView addSubview:number];
   
    
    //加号
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(MainScreenWidth - 20 - 20, 170, 20, 20)];
    addBtn.backgroundColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:addBtn];
    
}

-(void)closeBtnClick{
    [UIView beginAnimations:@"close" context:nil];
    [UIView setAnimationDuration:1];
    alphaView.frame = CGRectMake(0, MainScreenHeight, MainScreenWidth, 200);
    [UIView commitAnimations];
    
}

-(void)minusBtnClick{//减号点击
    if (number.text.integerValue == 1) {
        [self showTipWithText:@"数量至少为一件"];
        return;
    }
    
    number.text = [NSString stringWithFormat:@"%ld",number.text.integerValue - 1];
    
}

-(void)addBtnClick{//加号点击
    number.text = [NSString stringWithFormat:@"%ld",number.text.integerValue + 1];
    
}




-(void)goodsButtonClick{
    [goodsButton addSubview:redLine];
    
}

-(void)detailButtonClick{
    [detailButton addSubview:redLine];
    
}

-(void)appraiseButtonClick{
    [appraiseButton addSubview:redLine];
}

#pragma mark--UIscrollviewDelegate
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{//视图滑动的时候就调用
//    CGFloat x = scrollView.contentOffset.x;
//    if ( x == MainScreenWidth * 2) {
//         [detailButton addSubview:redLine];
//    }
//
//}
//视图滑动结束时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / MainScreenWidth;
    NSLog(@"第几个%ld",index);
    
    UIButton *button = [aview viewWithTag:index + 100];
//    [self didClickHeadButtonAction:button]
    [self didClickHeadButtonAction:button];
//    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
//    UIButton *button = _bgView.subviews[index];
//
//    [self topBottonClick:button];
//
//    [self addChildViewController];
}
//懒加载
-(AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, MainScreenHeight , MainScreenWidth, 215)];
        _pickerView.delegate = self;
        // 关闭默认支持打开上次的结果
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

-(void)btnClick{
    //
    [self.pickerView show];
//    btn.selected = !btn.selected;
//    if (btn.selected) {
//
//    }else{
//        [self.pickerView hide];
//    }
}
#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];
    
}
//完成按钮点击
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
//    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
//    [self btnClick:_addressBtn];
    [self.pickerView hide];
    
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    if (newController == oldController) {
        return;
    }
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
