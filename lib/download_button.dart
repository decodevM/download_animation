import 'package:flutter/cupertino.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {Key? key, this.buttonColor = CupertinoColors.activeBlue})
      : super(key: key);
  final Color buttonColor;
  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton>
    with TickerProviderStateMixin {
  final double buttonHeight = 50;
  final double buttonWidth = 300;

  bool _fadeAnimationCompleted = false;
  bool _animationCompleted = false;

  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  late AnimationController _opacityAnimationController;
  late Animation<double> _opacityAnimation;
  @override
  void initState() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation =
        Tween<double>(begin: 1, end: 1.05).animate(_scaleAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // Scale animation is completed now
              _scaleAnimationController.reverse();
              _fadeAnimationController.forward();
              _opacityAnimationController.forward();
            }
          });

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation =
        Tween<double>(begin: 50, end: 0).animate(_fadeAnimationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _fadeAnimationCompleted = true;
              print(_fadeAnimation.value);
              setState(() {});
            }
          });

    _opacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: buttonWidth)
        .animate(_opacityAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animationCompleted = true;
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _fadeAnimationController.dispose();
    _opacityAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _scaleAnimationController,
            builder: (context, child) => Transform.scale(
              scale: _scaleAnimation.value,
              child: GestureDetector(
                onTap: () {
                  _scaleAnimationController.forward();
                },
                child: Container(
                  height: 50,
                  width: buttonWidth,
                  decoration: BoxDecoration(
                      color: widget.buttonColor.withOpacity(.8),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _animationCompleted
                            ? const Icon(
                                CupertinoIcons.checkmark,
                                color: CupertinoColors.white,
                              )
                            : const Text(
                                'Download',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                      ),
                      AnimatedBuilder(
                        animation: _fadeAnimationController,
                        builder: (_, child) => Container(
                          height: buttonHeight,
                          width: _fadeAnimation.value,
                          decoration: BoxDecoration(
                              color: widget.buttonColor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: const Icon(
                                CupertinoIcons.arrow_down_to_line_alt,
                                color: CupertinoColors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (!_animationCompleted)
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (_, child) => Positioned(
                top: 0,
                left: 0,
                height: 50,
                width: _opacityAnimation.value,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: .5,
                  child: Container(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
