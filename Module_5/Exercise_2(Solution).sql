USE AdventureWorks

ALTER TABLE SALES.MEDIAOUTLET ADD CONSTRAINT IX_MEDIAOUTLET UNIQUE CLUSTERED (
MEDIAOUTLETID
);

CREATE UNIQUE CLUSTERED INDEX CIX_PRINTMEDIAPLACEMENT 
ON SALES.PRINTMEDIAPLACEMENT (PRINTMEDIAPLACEMENTID ASC);

