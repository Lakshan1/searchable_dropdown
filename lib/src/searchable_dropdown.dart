import 'package:flutter/material.dart';

import 'package:searchable_paginated_dropdown/src/extensions/extensions.dart';
import 'package:searchable_paginated_dropdown/src/model/searchable_dropdown_menu_item.dart';
import 'package:searchable_paginated_dropdown/src/searchable_dropdown_controller.dart';
import 'package:searchable_paginated_dropdown/src/utils/custom_inkwell.dart';
import 'package:searchable_paginated_dropdown/src/utils/custom_search_bar.dart';

class SearchableDropdown<T> extends StatefulWidget {
  const SearchableDropdown({
    Key? key,
    Widget? hintText,
    Widget Function(Widget)? backgroundDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? margin,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    List<SearchableDropdownMenuItem<T>>? items,
    T? value,
    bool isEnabled = true,
    VoidCallback? disabledOnTap,
    double? width,
    bool isDialogExpanded = true,
  }) : this._(
          key: key,
          hintText: hintText,
          backgroundDecoration: backgroundDecoration,
          searchHintText: searchHintText,
          noRecordText: noRecordText,
          dropDownMaxHeight: dropDownMaxHeight,
          margin: margin,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          onChanged: onChanged,
          items: items,
          value: value,
          isEnabled: isEnabled,
          disabledOnTap: disabledOnTap,
          width: width,
          isDialogExpanded: isDialogExpanded,
        );

  const SearchableDropdown.paginated({
    required Future<List<SearchableDropdownMenuItem<T>>?> Function(
      int,
      String?,
    )?
        paginatedRequest,
    int? requestItemCount,
    Key? key,
    Widget? hintText,
    Widget Function(Widget)? backgroundDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? margin,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    bool isEnabled = true,
    VoidCallback? disabledOnTap,
    Duration? changeCompletionDelay,
    double? width,
    bool isDialogExpanded = true,
    // Colors - Lakshan
    Color? dropdownBackgroundColor,
    Color? searchBackgroundColor,
    Icon? searchIcon,
    TextStyle? searchTextStyle,
    int dropdownTopMargin = 0,
    VoidCallback? onButtonClick,
    VoidCallback? onButtonClose,
    double? dropdownWidth,
    Color? searchCursorColor
  }) : this._(
          key: key,
          paginatedRequest: paginatedRequest,
          requestItemCount: requestItemCount,
          hintText: hintText,
          backgroundDecoration: backgroundDecoration,
          searchHintText: searchHintText,
          noRecordText: noRecordText,
          dropDownMaxHeight: dropDownMaxHeight,
          margin: margin,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          onChanged: onChanged,
          isEnabled: isEnabled,
          disabledOnTap: disabledOnTap,
          changeCompletionDelay: changeCompletionDelay,
          width: width,
          isDialogExpanded: isDialogExpanded,
          dropdownBackgroundColor: dropdownBackgroundColor,
          searchBackgroundColor: searchBackgroundColor,
          searchIcon: searchIcon,
          searchTextStyle: searchTextStyle,
          dropdownTopMargin: dropdownTopMargin,
          onButtonClick: onButtonClick,
          onButtonClose: onButtonClose,
          dropdownWidth: dropdownWidth,
          searchCursorColor: searchCursorColor
        );

  const SearchableDropdown.future({
    required Future<List<SearchableDropdownMenuItem<T>>?> Function()?
        futureRequest,
    Key? key,
    Widget? hintText,
    Widget Function(Widget)? backgroundDecoration,
    String? searchHintText,
    Widget? noRecordText,
    double? dropDownMaxHeight,
    EdgeInsetsGeometry? margin,
    Widget? trailingIcon,
    Widget? trailingClearIcon,
    Widget? leadingIcon,
    void Function(T?)? onChanged,
    bool isEnabled = true,
    VoidCallback? disabledOnTap,
    Duration? changeCompletionDelay,
    double? width,
    bool isDialogExpanded = true,
  }) : this._(
          futureRequest: futureRequest,
          key: key,
          hintText: hintText,
          backgroundDecoration: backgroundDecoration,
          searchHintText: searchHintText,
          noRecordText: noRecordText,
          dropDownMaxHeight: dropDownMaxHeight,
          margin: margin,
          trailingIcon: trailingIcon,
          trailingClearIcon: trailingClearIcon,
          leadingIcon: leadingIcon,
          onChanged: onChanged,
          isEnabled: isEnabled,
          disabledOnTap: disabledOnTap,
          changeCompletionDelay: changeCompletionDelay,
          width: width,
          isDialogExpanded: isDialogExpanded,
        );

  const SearchableDropdown._({
    super.key,
    this.hintText,
    this.backgroundDecoration,
    this.searchHintText,
    this.noRecordText,
    this.dropDownMaxHeight,
    this.margin,
    this.trailingIcon,
    this.trailingClearIcon,
    this.leadingIcon,
    this.onChanged,
    this.items,
    this.value,
    this.isEnabled = true,
    this.disabledOnTap,
    this.futureRequest,
    this.paginatedRequest,
    this.requestItemCount,
    this.changeCompletionDelay,
    this.width,
    this.isDialogExpanded = false,
    this.dropdownBackgroundColor,
    this.searchBackgroundColor,
    this.searchIcon,
    this.searchTextStyle,
    this.dropdownTopMargin = 0,
    this.onButtonClick,
    this.onButtonClose,
    this.dropdownWidth,
    this.searchCursorColor
  });

  //Is dropdown enabled
  final bool isEnabled;

  //If its true dialog will be expanded all width of screen, otherwise dialog will be same size of dropdown.
  final bool isDialogExpanded;

  /// Height of dropdown's dialog, default: context.deviceHeight*0.3.
  final double? dropDownMaxHeight;

  final double? width;

  /// Delay of dropdown's search callback after typing complete.
  final Duration? changeCompletionDelay;

  /// Dropdowns margin padding with other widgets.
  final EdgeInsetsGeometry? margin;

  /// Future service which is returns DropdownMenuItem list.
  final Future<List<SearchableDropdownMenuItem<T>>?> Function()? futureRequest;

  /// Paginated request service which is returns DropdownMenuItem list.
  final Future<List<SearchableDropdownMenuItem<T>>?> Function(
    int page,
    String? searchKey,
  )? paginatedRequest;

  /// Paginated request item count which returns in one page, this value is using for knowledge about isDropdown has more item or not.
  final int? requestItemCount;

  /// Dropdown items.
  final List<SearchableDropdownMenuItem<T>>? items;

  /// SearchBar hint text.
  final String? searchHintText;

  //Initial value of dropdown
  final T? value;

  //Triggers this function if dropdown pressed while disabled
  final VoidCallback? disabledOnTap;

  /// Returns selected Item.
  final void Function(T? value)? onChanged;

  /// Hint text shown when the dropdown is empty.
  final Widget? hintText;

  /// Shows if there is no record found.
  final Widget? noRecordText;

  /// Dropdown trailing icon.
  final Widget? trailingIcon;

  /// Dropdown trailing clear icon.
  final Widget? trailingClearIcon;

  /// Dropdown trailing icon.
  final Widget? leadingIcon;

  /// Background decoration of dropdown, i.e. with this you can wrap dropdown with Card.
  final Widget Function(Widget child)? backgroundDecoration;

  // Colors - Lakshan
  final Color? dropdownBackgroundColor;
  final Color? searchBackgroundColor;
  final Icon? searchIcon;
  final TextStyle? searchTextStyle;
  final int dropdownTopMargin;
  final VoidCallback? onButtonClick;
  final VoidCallback? onButtonClose;
  final double? dropdownWidth;
  final Color? searchCursorColor;

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final SearchableDropdownController<T> controller =
      SearchableDropdownController<T>();

  @override
  void initState() {
    controller
      ..paginatedRequest = widget.paginatedRequest
      ..futureRequest = widget.futureRequest
      ..requestItemCount = widget.requestItemCount ?? 0
      ..items = widget.items
      ..searchedItems.value = widget.items;
    for (final element in widget.items ?? <SearchableDropdownMenuItem<T>>[]) {
      if (element.value == widget.value) {
        controller.selectedItem.value = element;
        return;
      }
    }
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = _DropDown(
      controller: controller,
      isEnabled: widget.isEnabled,
      disabledOnTap: widget.disabledOnTap,
      dropDownMaxHeight: widget.dropDownMaxHeight,
      futureRequest: widget.futureRequest,
      hintText: widget.hintText,
      leadingIcon: widget.leadingIcon,
      margin: widget.margin,
      noRecordText: widget.noRecordText,
      onChanged: widget.onChanged,
      paginatedRequest: widget.paginatedRequest,
      searchHintText: widget.searchHintText,
      trailingIcon: widget.trailingIcon,
      trailingClearIcon: widget.trailingClearIcon,
      changeCompletionDelay: widget.changeCompletionDelay,
      isDialogExpanded: widget.isDialogExpanded,
      dropdownBackgroundColor: widget.dropdownBackgroundColor,
      searchBackgroundColor: widget.searchBackgroundColor,
      searchIcon: widget.searchIcon,
      searchTextStyle: widget.searchTextStyle,
      dropdownTopMargin: widget.dropdownTopMargin,
      onButtonClick: widget.onButtonClick,
    );

    return SizedBox(
      key: controller.key,
      width: widget.width ?? MediaQuery.of(context).size.width,
      child:TapRegion(
        behavior: HitTestBehavior.deferToChild,
        onTapInside: (event) {
          if (widget.isEnabled) {
            showDropdownDialog(context, controller);
          } else {
            widget.disabledOnTap?.call();
          }
          widget.onButtonClick?.call();
        },
        onTapOutside: (event) {
          widget.onButtonClose?.call();
        
        },
        child: widget.backgroundDecoration?.call(dropdownWidget) ?? dropdownWidget,
      )
          
    );
  }

  void showDropdownDialog(
    BuildContext context,
    SearchableDropdownController<T> controller,
  ) {
    var isReversed = false;
    final deviceHeight = context.deviceHeight;
    final dropdownGlobalPointBounds = controller.key.globalPaintBounds;
    final alertDialogMaxHeight = widget.dropDownMaxHeight ?? deviceHeight * 0.35;
    var dialogOffset = widget.dropdownTopMargin; //Dialog offset from dropdown

    final dropdownPositionFromBottom = dropdownGlobalPointBounds != null
        ? deviceHeight - dropdownGlobalPointBounds.bottom
        : null;
    var dialogPositionFromBottom = dropdownPositionFromBottom != null
        ? dropdownPositionFromBottom - alertDialogMaxHeight
        : null;
    if (dialogPositionFromBottom != null) {
      //If dialog couldn't fit the screen, reverse it
      if (dialogPositionFromBottom <= 0) {
        isReversed = true;
        final dropdownHeight = dropdownGlobalPointBounds?.height ?? 54;
        dialogPositionFromBottom +=
            alertDialogMaxHeight + dropdownHeight - dialogOffset;
      } else {
        dialogPositionFromBottom -= dialogOffset;
      }
    }
    if (controller.items == null) {
      if (widget.paginatedRequest != null) {
        controller.getItemsWithPaginatedRequest(page: 1, isNewSearch: true);
      }
      if (widget.futureRequest != null) controller.getItemsWithFutureRequest();
    } else {
      controller.searchedItems.value = controller.items;
    }
    //Show the dialog
    showDialog<void>(
      context: context,
      builder: (context) {
        var reCalculatePosition = dialogPositionFromBottom;
        final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
        //If keyboard pushes the dialog, recalculate the dialog's position.
        if (reCalculatePosition != null &&
            reCalculatePosition <= keyboardHeight) {
          reCalculatePosition =
              (keyboardHeight - reCalculatePosition) + reCalculatePosition;
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: reCalculatePosition ?? 0,
            left: widget.isDialogExpanded ? 16 : dropdownGlobalPointBounds?.left ?? 0,
            right: widget.isDialogExpanded ? 16 : 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: widget.isDialogExpanded
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: alertDialogMaxHeight,
                width:
                    widget.isDialogExpanded ? null : dropdownGlobalPointBounds?.width,
                child: _DropDownCard(
                  controller: controller,
                  isReversed: isReversed,
                  noRecordText: widget.noRecordText,
                  onChanged: widget.onChanged,
                  paginatedRequest: widget.paginatedRequest,
                  searchHintText: widget.searchHintText,
                  changeCompletionDelay: widget.changeCompletionDelay,
                  dropdownBackgroundColor: widget.dropdownBackgroundColor,
                  searchBackgroundColor: widget.searchBackgroundColor,
                  searchIcon: widget.searchIcon,
                  searchTextStyle: widget.searchTextStyle,
                  dropdownWidth: widget.dropdownWidth,
                  searchCursorColor: widget.searchCursorColor,
                ),
              ),
            ],
          ),
        );
      },
      barrierColor: Colors.transparent,
    );
  }
}


class _DropDown<T> extends StatelessWidget {
  const _DropDown({
    required this.controller,
    required this.isEnabled,
    required this.isDialogExpanded,
    this.leadingIcon,
    this.trailingIcon,
    this.trailingClearIcon,
    this.disabledOnTap,
    this.margin,
    this.hintText,
    this.dropDownMaxHeight,
    this.futureRequest,
    this.paginatedRequest,
    this.noRecordText,
    this.onChanged,
    this.searchHintText,
    this.changeCompletionDelay,
    this.dropdownBackgroundColor,
    this.searchBackgroundColor,
    this.searchIcon,
    this.searchTextStyle,
    this.dropdownTopMargin = 0,
    this.onButtonClick,
  });

  final bool isEnabled;
  final bool isDialogExpanded;
  final double? dropDownMaxHeight;
  final Duration? changeCompletionDelay;
  final EdgeInsetsGeometry? margin;
  final Future<List<SearchableDropdownMenuItem<T>>?> Function()? futureRequest;
  final Future<List<SearchableDropdownMenuItem<T>>?> Function(
    int page,
    String? searchKey,
  )? paginatedRequest;
  final SearchableDropdownController<T> controller;
  final String? searchHintText;
  final VoidCallback? disabledOnTap;
  final void Function(T? value)? onChanged;
  final Widget? trailingIcon;
  final Widget? trailingClearIcon;
  final Widget? leadingIcon;
  final Widget? hintText;
  final Widget? noRecordText;

  // Colors - Lakshan
  final Color? dropdownBackgroundColor;
  final Color? searchBackgroundColor;
  final Icon? searchIcon;
  final TextStyle? searchTextStyle;
  final int dropdownTopMargin;
  final VoidCallback? onButtonClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: margin ?? const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (leadingIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: leadingIcon,
                    ),
                  Flexible(
                    child: _DropDownText(
                      controller: controller,
                      hintText: hintText,
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller.selectedItem,
              builder: (context, value, child) {
                if (value == null) {
                  return trailingIcon ??
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                      );
                }
                return CustomInkwell(
                  padding: EdgeInsets.zero,
                  onTap: () {
                    controller.selectedItem.value = null;
                    onChanged?.call(null);
                  },
                  child: trailingClearIcon ??
                      const Icon(
                        Icons.clear,
                        size: 24,
                      ),
                );
              },
            ),
          ],
        ),
      );
  }
}

class _DropDownText<T> extends StatelessWidget {
  const _DropDownText({
    required this.controller,
    this.hintText,
  });

  final SearchableDropdownController<T> controller;
  final Widget? hintText;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.selectedItem,
      builder: (context, SearchableDropdownMenuItem<T>? selectedItem, child) =>
          selectedItem?.child ??
          (selectedItem?.label != null
              ? Text(
                  selectedItem!.label,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ) 
              : hintText) ??
          const SizedBox.shrink(),
    );
  }
}

class _DropDownCard<T> extends StatelessWidget {
  const _DropDownCard({
    required this.controller,
    required this.isReversed,
    this.searchHintText,
    this.paginatedRequest,
    this.onChanged,
    this.noRecordText,
    this.changeCompletionDelay,
    this.dropdownBackgroundColor,
    this.searchBackgroundColor,
    this.searchIcon,
    this.searchTextStyle,
    this.dropdownWidth,
    this.searchCursorColor
  });

  final bool isReversed;
  final Duration? changeCompletionDelay;
  final Future<List<SearchableDropdownMenuItem<T>>?> Function(
    int page,
    String? searchKey,
  )? paginatedRequest;
  final SearchableDropdownController<T> controller;
  final String? searchHintText;
  final void Function(T? value)? onChanged;
  final Widget? noRecordText;

  //Lakshan
  final Color? dropdownBackgroundColor;
  final Color? searchBackgroundColor;
  final Icon? searchIcon;
  final TextStyle? searchTextStyle;
  final double? dropdownWidth;
  final Color? searchCursorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dropdownWidth ?? MediaQuery.of(context).size.width,
      child: Column(
      mainAxisAlignment:
          isReversed ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible( 
          child: Card(
            color: dropdownBackgroundColor ?? Colors.white, //need to make it dynamic by get this as argument
            surfaceTintColor: dropdownBackgroundColor,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:0,bottom: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                verticalDirection:
                    isReversed ? VerticalDirection.up : VerticalDirection.down,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: dropdownBackgroundColor ?? Colors.white, //need to make it dynamic by get this as argument
                      borderRadius: BorderRadius.vertical(top:Radius.circular(8)),
                    ),
                    child: _DropDownSearchBar(
                      controller: controller,
                      searchHintText: searchHintText,
                      changeCompletionDelay: changeCompletionDelay,
                      searchIcon: searchIcon,
                      searchTextStyle: searchTextStyle,
                      searchBackgroundColor: searchBackgroundColor,
                      searchCursorColor: searchCursorColor,
                    ),
                  ),
                  Flexible(
                    child: _DropDownListView(
                      controller: controller,
                      paginatedRequest: paginatedRequest,
                      isReversed: isReversed,
                      noRecordText: noRecordText,
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}

class _DropDownSearchBar<T> extends StatelessWidget {
  const _DropDownSearchBar({
    required this.controller,
    this.searchHintText,
    this.changeCompletionDelay,
    this.searchIcon,
    this.searchTextStyle,
    this.searchBackgroundColor,
    this.searchCursorColor
  });
  final Duration? changeCompletionDelay;
  final SearchableDropdownController<T> controller;
  final String? searchHintText;
  
  //Lakshan
  final Icon? searchIcon;
  final TextStyle? searchTextStyle;
  final Color? searchBackgroundColor;
  final Color? searchCursorColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CustomSearchBar(
        focusNode: controller.searchFocusNode,
        changeCompletionDelay:
            changeCompletionDelay ?? const Duration(milliseconds: 200),
        hintText: searchHintText ?? 'Search',
        isOutlined: false,
        leadingIcon: searchIcon ?? Icon(Icons.search, size: 24, color: Colors.black,), //need to make it dynamic by get this as argument
        style: searchTextStyle ?? TextStyle(color: Colors.white), //need to make it dynamic by get this as argument
        backgrundColor: searchBackgroundColor ?? Colors.white,
        cursorColor: searchCursorColor ?? Colors.white,
        onChangeComplete: (value) {
          controller.searchText = value;
          if (controller.items != null) {
            controller.fillSearchedList(value);
            return;
          }
          controller.getItemsWithPaginatedRequest(
            key: value == '' ? null : value,
            page: 1,
            isNewSearch: true,
          );
        },
      ),
    );
  }
}

class _DropDownListView<T> extends StatelessWidget {
  const _DropDownListView({
    required this.controller,
    required this.isReversed,
    this.paginatedRequest,
    this.noRecordText,
    this.onChanged,
  });

  final bool isReversed;
  final Future<List<SearchableDropdownMenuItem<T>>?> Function(
    int page,
    String? searchKey,
  )? paginatedRequest;
  final SearchableDropdownController<T> controller;
  final void Function(T? value)? onChanged;
  final Widget? noRecordText;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: paginatedRequest != null
          ? controller.paginatedItemList
          : controller.searchedItems,
      builder: (
        context,
        List<SearchableDropdownMenuItem<T>>? itemList,
        child,
      ) =>
          itemList == null
              ? const Center(child: CircularProgressIndicator.adaptive())
              : itemList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: noRecordText ?? const Text('No record'),
                    )
                  : Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: false,
                      thickness: 0,
                      controller: controller.scrollController,
                      child: NotificationListener(
                        child: ListView.builder(
                          controller: controller.scrollController,
                          padding: listViewPadding(isReversed: isReversed),
                          itemCount: itemList.length + 1,
                          shrinkWrap: true,
                          reverse: isReversed,
                          itemBuilder: (context, index) {
                            if (index < itemList.length) {
                              final item = itemList.elementAt(index);
                              return CustomInkwell(
                                child: item.child,
                                onTap: () {
                                  controller.selectedItem.value = item;
                                  onChanged?.call(item.value);
                                  Navigator.pop(context);
                                  item.onTap?.call();
                                },
                              );
                            } else {
                              return ValueListenableBuilder(
                                valueListenable: controller.status,
                                builder: (
                                  context,
                                  SearchableDropdownStatus state,
                                  child,
                                ) {
                                  if (state == SearchableDropdownStatus.busy) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
    );
  }

  EdgeInsets listViewPadding({required bool isReversed}) {
    const itemHeight = 10.0; //Needed offset to show progress indicator
    return EdgeInsets.only(
      left: 8,
      right: 8,
      bottom: isReversed ? 0 : itemHeight,
      top: isReversed ? itemHeight : 0,
    );
  }
}
