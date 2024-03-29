#  CHANGELOG

* Doing

	+ (May) lookup baseline reset issue with overflowing text

* 0.16.0 - 0.17.0

	+ Update README.md

* 0.15.0

	+ Added `ImperativeViewController` 

* 0.12.0 - 0.14.0

	+ Update `README.md`

* 0.10.0 - 0.11.0

	+ Added `MarsViewController` 

* Feature/Label_Styles/0.1.5

	+ Moved constants into `UI`
	+ Added `MockupViewController`

* Feature/Label_Styles/0.1.3 - 0.1.4

	+ Added scroll view to `PlanetViewController`
	+ Matched inspection border to Figma

* Feature/Label_Styles/0.1.2

	+ UI from design specs (label styles, assets, stack)
	+ `baselineOffset` adjustemt for small line heigh values

* Feature/Label_Styles/0.1.0

	+ Added `PlanetViewController` with labels and (inline) styles
	+ Renaming, warning cleanup

* 0.9.0

	+ Cleanup, renamings

* Feature/Empty_Label_Support/0.2.0 - 0.2.1

	+ Added `oldText` and `newText` parameters to `onTextChange` observer
	+ Renamed `placeholder` to `cache`
	+ Apply cached attributes (if any) in case text have just changed from empty on text change
	+ More testbed cleanup

* Feature/Empty_Label_Support/0.1.9

	+ Cleaned up testbed views

* Feature/Empty_Label_Support/0.1.8

	+ Cleanup files and folders

* Feature/Empty_Label_Support/0.1.7

	+ Removed unused parameter from `onTextChange()`
	+ Added `NSMutableParagraphStyle.withProperty()` to mutate paragraph style in place
	
* Feature/Empty_Label_Support/0.1.6

	+ Added `NSParagraphStyle.paragraphStyleByAddingProperty` for in-place(ish) mutation
	+ Copied text alignment at paragraph style mutation(s)

* Feature/Empty_Label_Support/0.1.5

	+ Added empty string ("") and `textAlignment` mutation to testbed

* Feature/Empty_Label_Support/0.1.4

	+ Added `UILabel.placeholder` attributed string to cache typography even when text is empty
	+ Added `NSMutableString` extensions for in-place(ish) mutation
		+ `NSMutableString.stringByAddingAttribute`
		+ `NSMutableString.stringByRemovingAttribute`

* Feature/Empty_Label_Support/0.1.0 - 0.1.2

	+ Added `CHANGELOG.md`
	+ Reuse `TextObserver.OnChangeAction` in `UILabel` text observer extension
	+ Renamings

* Feature/Empty_Label_Support

	+ Merged `attributes-lost-when-text-is-empty` from Adrian Zyga

* 0.0.0 - 0.8.1

	+ Initial implementation
	+ Testbed
