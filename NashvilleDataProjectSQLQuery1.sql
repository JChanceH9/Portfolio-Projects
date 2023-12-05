select SaleDate, convert(date,SaleDate)
from NashvilleHousing.dbo.Sheet1$

update NashvilleHousing.dbo.Sheet1$
Set Saledate = convert(date(,Saledate)

select SaleDateConverted
from NashvilleHousing.dbo.Sheet1$

Alter Table NashvilleHousing.dbo.sheet1$
Add SaleDateConverted date;

update NashvilleHousing.dbo.Sheet1$
Set SaleDateConverted = convert(date,Saledate)

select *
from NashvilleHousing.dbo.Sheet1$
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress,b.PropertyAddress)
from NashvilleHousing.dbo.Sheet1$ a
join NashvilleHousing.dbo.Sheet1$ b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.propertyaddress,b.PropertyAddress)
from NashvilleHousing.dbo.Sheet1$ a
join NashvilleHousing.dbo.Sheet1$ b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]

SELECT
SUBSTRING(PROPERTYADDRESS, 1, CHARINDEX(',', PROPERTYADDRESS) -1) AS ADDRESS
, SUBSTRING(PROPERTYADDRESS, CHARINDEX(',', PROPERTYADDRESS)+1, LEN(PROPERTYADDRESS)) AS ADDRESS
FROM NashvilleHousing.DBO.Sheet1$

Alter Table NashvilleHousing.dbo.sheet1$
Add PropertySplitAddress nvarchar(255);

update NashvilleHousing.dbo.Sheet1$
Set PropertySplitAddress = SUBSTRING(PROPERTYADDRESS, 1, CHARINDEX(',', PROPERTYADDRESS) -1)

Alter Table NashvilleHousing.dbo.sheet1$
Add PropertySplitCity nvarchar(255);

update NashvilleHousing.dbo.Sheet1$
Set PropertySplitCity = SUBSTRING(PROPERTYADDRESS, CHARINDEX(',', PROPERTYADDRESS)+1, LEN(PROPERTYADDRESS))

select *
from NashvilleHousing.dbo.Sheet1$

SELECT
PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3)
, PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2)
, PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)
from NashvilleHousing.dbo.Sheet1$

Alter Table NashvilleHousing.dbo.sheet1$
Add OwnerSplitAddress nvarchar(255);

update NashvilleHousing.dbo.Sheet1$
Set OwnerSplitAddress = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 3)

Alter Table NashvilleHousing.dbo.sheet1$
Add OwnerSplitCity nvarchar(255);

update NashvilleHousing.dbo.Sheet1$
Set OwnerSplitCity = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 2)

Alter Table NashvilleHousing.dbo.sheet1$
Add OwnerSplitState nvarchar(255);

update NashvilleHousing.dbo.Sheet1$
Set OwnerSplitState = PARSENAME(REPLACE(OWNERADDRESS, ',', '.'), 1)

select owneraddress, OwnerSplitAddress, OwnerSplitCity, OwnerSplitState
from NashvilleHousing.dbo.Sheet1$

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From NashvilleHousing.DBO.Sheet1$
Group by SoldAsVacant
Order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' Then 'Yes'
	   When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
From NashvilleHousing.DBO.Sheet1$

Update NashvilleHousing.DBO.Sheet1$
Set SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
	   When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End

With RowNumCTE as(
Select *,
	ROW_NUMBER() Over (
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by UniqueID
				 ) row_num
From NashvilleHousing.DBO.Sheet1$
--Order by ParcelID
)
Delete
From RowNumCTE
Where row_num > 1

Select *
From NashvilleHousing.DBO.Sheet1$

ALTER TABLE NashvilleHousing.DBO.Sheet1$
DROP COLUMN OWNERADDRESS, TAXDISTRICT, PROPERTYADDRESS, SALEDATE

