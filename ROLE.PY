{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::548194410066:user/nd69-s-sgst6886"
			},
			"Action": "sts:AssumeRole",
			"Condition": {
				"StringEquals": {
					"sts:ExternalId": "OL98450_SFCRole=3_DXLTHIFCJKleMiVQtJNEfpY7xBI="
				}
			}
		}
	]
}

--------------------------------------------------------------------------------------------------------------------------