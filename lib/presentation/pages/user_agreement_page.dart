import 'package:enkripa_sign/presentation/pages/input_data_personal_page.dart';
import 'package:enkripa_sign/presentation/pages/widget/navigation_widget.dart';
import 'package:enkripa_sign/presentation/pages/widget/user_areement_widget.dart';
import 'package:enkripa_sign/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class UserAgreementPage extends StatefulWidget {
  const UserAgreementPage({super.key});

  @override
  State<UserAgreementPage> createState() => _UserAgreementPageState();
}

class _UserAgreementPageState extends State<UserAgreementPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;
  bool _isAgree = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  //DISPOSE
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  //ONSCROLL
  void _onScroll() {
    final isAtBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent;

    if (isAtBottom != _isAtBottom) {
      setState(() {
        _isAtBottom = isAtBottom;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          titleSpacing: 16,
          surfaceTintColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.amber,
              child: Divider(
                height: 1.2,
                thickness: 1.2,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          title: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Nav.pop(context);
                  },
                  child: SvgPicture.asset('assets/icon/arrow-left-icon.svg',
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).fontColor, BlendMode.srcIn))),
              const SizedBox(width: 12),
              Text(
                'Persetujuan Pengguna',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: HtmlWidget(
                  contentUserAgreement,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).dividerColor)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _isAgree,
                        activeColor: Theme.of(context).enableButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(color: Theme.of(context).dividerColor),
                        onChanged: (value) {
                          setState(() {
                            _isAgree = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Saya menyetujui semua syarat, ketentuan, dan kebijakan privasi yang berlaku. ',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Theme.of(context).fontColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: Divider(
                  thickness: 1.2,
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.paddingOf(context).bottom + 20),
                child: Material(
                  color: _isAgree
                      ? Theme.of(context).enableButtonColor
                      : Theme.of(context).disabledButtonColor,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      if (_isAgree) {
                        Nav.push(context, const InputDataPersonalPage());
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    splashColor: Colors.white.withOpacity(0.2),
                    child: SizedBox(
                      height: 52,
                      child: Center(
                        child: Text(
                          'Saya Setuju',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _isAgree
                                ? Theme.of(context).enableFontColor
                                : Theme.of(context).disabledFontColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: _isAtBottom
            ? null
            : Material(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).enableButtonColor,
                child: InkWell(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: const SizedBox(
                    width: 48,
                    height: 48,
                    child:
                        Icon(Icons.arrow_downward_sharp, color: Colors.white),
                  ),
                ),
              ));
  }
}
