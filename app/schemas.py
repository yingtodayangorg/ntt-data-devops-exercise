from pydantic import BaseModel, Field

class MessageIn(BaseModel):
    message: str = Field(..., min_length=1)
    to: str = Field(..., min_length=1)
    from_: str = Field(..., alias='from', min_length=1)
    timeToLifeSec: int = Field(..., ge=1)

    class Config:
        allow_population_by_field_name = True
