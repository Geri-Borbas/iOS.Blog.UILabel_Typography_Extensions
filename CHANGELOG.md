#  CHANGELOG


* Doing

	+ Preserve text alignment (and other paragraph styles)
		+ Mutate `paragraphStyle` attributes similar to text attributes

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

