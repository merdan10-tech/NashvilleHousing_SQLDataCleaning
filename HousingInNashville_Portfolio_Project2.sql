/*

Cleaning Data in SQL Queries

*/

-- FAMILIRIZING WITH DATASET
SELECT *
FROM PortfolioProjects..NashvilleHousing


--------------------------------------------------------------------------------------------------------------------------


-- CHANGE "SaleDate" COLUMN TO STANDARDIZED DATE FORMAT

SELECT SaleDate, CONVERT(DATE, SaleDate)
FROM PortfolioProjects..NashvilleHousing

-- Adding New Column
ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date

-- Setting New Column to the created standardized date format values 
UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(DATE, SaleDate)


 --------------------------------------------------------------------------------------------------------------------------


 -- POPULATE "PropertyAddress" COLUMN WITH MISSING VALUES

-- Self Joined the tables and created a logic to populate NULL values in "a.PropertyAddress"
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProjects..NashvilleHousing AS a
JOIN PortfolioProjects..NashvilleHousing AS b
ON a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

-- Updated the "a.PropertyAddress" column with new populated column (only where "a.PropertyAddress" is NULL) 
UPDATE a
SET	PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProjects..NashvilleHousing AS a
JOIN PortfolioProjects..NashvilleHousing AS b
ON a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--------------------------------------------------------------------------------------------------------------------------


-- WORK WITH "PropertyAddress" AND BREAK INTO INTO: (Address, City)

SELECT 
-- Split the address from the "PropertyAddress" using substring. We need "-1" to remove comma from the end of new column
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
-- Split the city from the "PropertyAddress". We need len() func to indentify the length of the word
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))  AS Address
FROM PortfolioProjects..NashvilleHousing

-- Add two new columns and populate them
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255);
UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity NVARCHAR(255);
UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


--------------------------------------------------------------------------------------------------------------------------


-- UPDATE "OwnerAddress" TO SPLIT IT INTO: (Address, City, State)

-- Another method of splitting column into several columns. USing ParseName() method
-- Changing delimeter from comma to dot bc ParseName() works usually with dots
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProjects..NashvilleHousing

-- Add three new columns and feed it with the split values 
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress NVARCHAR(255);
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing 
ADD OwnerSplitCity NVARCHAR(255);
UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing 
ADD OwnerSplitState NVARCHAR(255);
UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


-----------------------------------------------------------------------------------------------------------------------------------------------------------


-- CHANGE 'Y' and 'N' VALUES IN THE "SoldAsVacant" COLUMN TO 'Yes' and 'No' RESPECTIVELY
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProjects..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

-- Utilizing the Case statement 
SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
FROM PortfolioProjects..NashvilleHousing

-- Update the current column with the new derived values for "Y" and "N"
UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


---------------------------------------------------------------------------------------------------------


-- REMOVE DUPLICATE ROWS FROM THE DATASET

-- Utilize the Common Table Expression (CTE) and Row_Number() func to find duplicates
WITH RowNumCTE AS (
SELECT *,
		ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
					 PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY 
						UniqueID
						) row_num
FROM PortfolioProjects..NashvilleHousing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress


---------------------------------------------------------------------------------------------------------


-- DELETE UNUSED COLUMNS FROM THE DATASET

ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate

SELECT *
FROM PortfolioProjects..NashvilleHousing